<?

class PlanController extends Zend_Rest_Controller
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
	 * Create Action
	 * 
	 */
	public function postAction( )
	{
		$params = $this->_getAllParams();
		error_log("Creating Plan");
		error_log(print_r($params, true));

		$guid = uniqid('plan-', true);

		$response = $this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $guid),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['name'])
			)
		));

		$retval = Zend_Json::encode(array("pid" => $guid));

		$this->getResponse()->appendBody($retval);
	}

	/**
	 * @param array $params
	 */
	public function deleteAction( )
	{
		$params = $this->_getAllParams();
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
	public function indexAction()
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
		
		$retval = Zend_Json::encode($plans);
	
		$this->getResponse()->appendBody($retval);
	}

	/**
	 * @param array $params
	 */
	public function putAction( )
	{
		$params = $this->_getAllParams();
		error_log("Updating Plan");
		error_log(print_r($params, true));

		$response = $this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['pid']),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['name'])
			)
		));
	}
}

?>