<?
class PlanService
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
	public function addPlan( $params )
	{
		$guid = uniqid('plan-', true);

		$this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $guid),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['name'])
			)
		));

		$retval = '{"pid":"' . $guid . '"}';
		
		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function deletePlan( $params )
	{
		$this->db->delete_item(array(
			'TableName' => 'DCD-Plans',
			'Key' => array(
				'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $params['pid'] )
			)
		));
	}

	/**
	 * @return string
	 */
	public function loadAllPlans()
	{
		$response = $this->db->scan(array(
			'TableName' => 'DCD-Plans'
		));
		
		$plans = array();
		$plan = array();
		$list = array();
		$class = $response->body->to_stdClass();
		
		if( $class->Count > 1 )
		{
		    $list = $class->Items;
		}
		elseif( $class->Count == 1 )
		{
		    $list = array($class->Items);
		}
		
		foreach( $list as $item ) {
			$plan = array("pid" => $item->pid->{AmazonDynamoDB::TYPE_STRING}, "name" => $item->name->{AmazonDynamoDB::TYPE_STRING});
			array_push($plans, $plan);
		}
		
		$retval = json_encode($plans);
	
		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function updatePlan( $params )
	{
		$this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['pid']),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['name'])
			)
		));
	}
}
?>
