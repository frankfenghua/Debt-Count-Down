<?
class DebtService
{
	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------

	/**
	 * @private
	 */
	private $db;

	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------

	/**
	 *
	 */
	public function __construct()
	{
		$this->db = new AmazonDynamoDB();
	}

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param array $params
	 */
	public function addDebt($params)
	{
		$guid = uniqid('debt-', true);

		$plans = array();
		$debt = $params['debt'];
		
		if( $debt['active'] == 'true' )
		{
		    array_push($plans, $params['planId']);
		}
		
		$data = array(
			'TableName' => 'DCD-Debts',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $guid ),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $debt['name'] ),
			        'bank' => array( AmazonDynamoDB::TYPE_STRING => $debt['bank'] ),
			        'balance' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['balance'] ),
			        'apr' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['apr'] ),
			        'paymentRate' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['paymentRate'] )
			)
		);
		
		if( count($plans) )
		{
		    $data['Item']['plans'] = array( AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS => array_values($plans) );
		}

		$response = $this->db->put_item($data);
		
		$retval = '{"pid":"' . $guid . '"}';
		
		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function deleteDebt($params)
	{
		$this->db->delete_item(array(
			'TableName' => 'DCD-Debts',
			'Key' => array(
				'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $params['pid'] )
			)
		));
	}

	/**
	 * @param array $params
	 */
	public function loadAllDebts($params)
	{
	    $response = $this->db->scan(array(
		'TableName' => 'DCD-Debts'
	    ));
	    
	    $debts = array();
	    $debt = array();
	    $class = $response->body->to_stdClass();
	    $list = array();
	    $plans = array();
	    
	    if( $class->Count > 1 )
	    {
		$list = $class->Items;
	    }
	    elseif( $class->Count == 1 )
	    {
		$list = array($class->Items);
	    }
	    
	    foreach( $list as $item ) {
		$debt = array(
		    'pid' => $item->pid->{AmazonDynamoDB::TYPE_STRING},
		    'name' => $item->name->{AmazonDynamoDB::TYPE_STRING},
		    'bank' => $item->bank->{AmazonDynamoDB::TYPE_STRING},
		    'balance' => $item->balance->{AmazonDynamoDB::TYPE_NUMBER},
		    'apr' => $item->apr->{AmazonDynamoDB::TYPE_NUMBER},
		    'paymentRate' => $item->paymentRate->{AmazonDynamoDB::TYPE_NUMBER},
		    'plans' => $item->plans->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS},
		    'active' => false
		);
		
		$plans = explode(',', $debt['plans']->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS});
		    
		if( in_array($params['planId'], $plans) ) {
		    $debt['active'] = true;
		}
		
		array_push($debts, $debt);
	    }
	    
	    $retval = json_encode($debts);
	    
	    echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function updateDebt($params)
	{
	    // first we need to fetch the debt so we can see it's existing 'plans' set
	    // then determine if the current planId needs to be added or removed
	    // from that set
	    // Then we update the debt on the server
	    
	    $debt = $params['debt'];
	    
	    $response = $this->db->get_item(array(
		'TableName' => 'DCD-Debts',
		'Key' => array( 'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $debt['pid'] ) )
	    ));
	    
	    $class = $response->body->to_stdClass()->Item;
	    
	    $plans = explode(',', $class->plans->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS});
	    
	    // trim $plans in case it is empty
	    for( $i = 0; $i < count($plans); $i++ ) {
		if( !strlen($plans[$i]) ) {
		    unset($plans[$i]);
		}
	    }
	    
	    if( $debt['active'] == 'true' )
	    {
		if( !in_array($params['planId'], $plans) )
		{
		    array_push($plans, $params['planId']);
		}
	    }
	    else
	    {
		error_log("Removing plan");
		if( in_array($params['planId'], $plans) )
		{
		    for( $i=0; $i < count($plans); $i++ ) {
			if( $plans[$i] == $params['planId'] ) {
			    error_log("Mad slizice");
			    unset($plans[$i]);
			}
		    }
		}
	    }
	    
	    $data = array(
		'TableName' => 'DCD-Debts',
		'Item' => array(
		    'pid' => array( AmazonDynamoDB::TYPE_STRING => $debt['pid'] ),
		    'name' => array( AmazonDynamoDB::TYPE_STRING => $debt['name'] ),
		    'bank' => array( AmazonDynamoDB::TYPE_STRING => $debt['bank'] ),
		    'balance' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['balance'] ),
		    'apr' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['apr'] ),
		    'paymentRate' => array( AmazonDynamoDB::TYPE_NUMBER => $debt['paymentRate'] )
		)
	    );
	    
	    // only include them if it has a set or it will fail
	    if( count($plans) )
	    {
		$data['Item']['plans'] = array( AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS => array_values($plans) );
	    }
	    
	    $response = $this->db->put_item($data);
	}
}
?>