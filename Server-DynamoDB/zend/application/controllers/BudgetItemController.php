<?
class BudgetItemController extends Zend_Rest_Controller
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
	// Methods
	//
	//-------------------------------------------------------------------------

	public function init()
    {
    	$this->db = new AmazonDynamoDB();
        $this->_helper->viewRenderer->setNoRender(true);
    }

    public function getAction()
    {

    }

	/**
	 * @param array $params
	 */
	public function postAction()
	{
		$params = $this->_getAllParams();

	    $plans = array();
	    $item = $params['item'];
	    
	    $guid = uniqid('item-', true);
	    
	    if( $item['active'] == 'true' )
	    {
			array_push($plans, $params['planId']);
	    }
	    
	    $data = array(
			'TableName' => 'DCD-BudgetItems',
			'Item' => array(
			    'pid' => array( AmazonDynamoDB::TYPE_STRING => $guid ),
			    'name' => array( AmazonDynamoDB::TYPE_STRING => $item['name'] ),
			    'amount' => array( AmazonDynamoDB::TYPE_NUMBER => $item['amount'] ),
			    'type' => array( AmazonDynamoDB::TYPE_STRING => $item['type'] )
			)
	    );
	    
	    if( count($plans) )
	    {
			$data['Item']['plans'] = array( AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS => array_values($plans) );
	    }
	    
	    $response = $this->db->put_item($data);
	    
	    $retval = Zend_Json::encode(array("pid" => $guid));
	    
	    $this->getResponse()->appendBody($retval);
	}

	/**
	 * @param array $params
	 */
	public function deleteAction()
	{
		$params = $this->_getAllParams();

	    $this->db->delete_item(array(
			'TableName' => 'DCD-BudgetItems',
			'Key' => array(
			    'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $params['pid'] )
			)
	    ));
	}

	/**
	 * @param array $params
	 */
	public function indexAction()
	{
		$params = $this->_getAllParams();
	    $response = $this->db->scan(array(
			'TableName' => 'DCD-BudgetItems'
	    ));
	    
	    $items = array();
	    $item = array();
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
	    
	    foreach( $list as $item ) 
	    {
			$item = array(
			    'pid' => $item->pid->{AmazonDynamoDB::TYPE_STRING},
			    'name' => $item->name->{AmazonDynamoDB::TYPE_STRING},
			    'amount' => $item->amount->{AmazonDynamoDB::TYPE_NUMBER},
			    'type' => $item->type->{AmazonDynamoDB::TYPE_STRING},
			    'plans' => $item->plans->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS},
			    'active' => false
			);
		    
			$plans = explode(',', $item['plans']->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS});
		
			if( in_array($params['planId'], $plans) )
			{
			    $item['active'] = true;
			}
			
			array_push($items, $item);
	    }
	    
	    $retval = Zend_Json::encode($items);

	    $this->getResponse()->appendBody($retval);
	}

	/**
	 * @param array $params
	 */
	public function putAction()
	{
		$params = $this->_getAllParams();
	    $item = $params['item'];
	    
	    $response = $this->db->get_item(array(
			'TableName' => 'DCD-BudgetItems',
			'Key' => array( 'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $item['pid'] ) )
	    ));
	    
	    $class = $response->body->to_stdClass()->Item;
	    
	    $plans = explode(',', $class->plans->{AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS});
	    
	    for( $i = 0; $i < count($plans); $i++ )
	    {
			if( !strlen($plans[$i]) )
			{
		    	unset($plans[$i]);
			}
	    }
	    
	    if( $item['active'] == 'true' )
	    {
			if( !in_array($params['planId'], $plans) )
			{
		 	   array_push($plans, $params['planId']);
			}
	    }
	    else
	    {
			if( in_array($params['planId'], $plans) )
			{
				for( $i = 0; $i < count($plans); $i++ )
		    	{
				if( $plans[$i] == $params['planId'] )
				{
			    	unset($plans[$i]);
				}
		    	}
			}
	    }
	    
	    $data = array(
			'TableName' => 'DCD-BudgetItems',
			'Item' => array(
			    'pid' => array( AmazonDynamoDB::TYPE_STRING => $item['pid'] ),
			    'name' => array( AmazonDynamoDB::TYPE_STRING => $item['name'] ),
			    'amount' => array( AmazonDynamoDB::TYPE_NUMBER => $item['amount'] ),
			    'type' => array( AmazonDynamoDB::TYPE_STRING => $item['type'] )
			)
	    );
	    
	    if( count($plans) )
	    {
			$data['Item']['plans'] = array( AmazonDynamoDB::TYPE_ARRAY_OF_STRINGS => array_values($plans) );
	    }
	    
	    $response = $this->db->put_item($data);
	}
}
?>