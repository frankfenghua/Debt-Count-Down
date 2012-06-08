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
		error_log("Updating Plan");
		error_log(print_r($params, true));

		$guid = uniqid('plan-', true);

		$response = $this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $guid),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['name'])
			)
		));

		$retval = '{"pid":"' . $guid . '"}';
		
		echo $retval;

		error_log("Add Plan Response:");
		error_log(print_r($response, true));
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
		error_log("Load All Plans");

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

		error_log("Load All Plans Response: ");
		error_log(print_r($response, true));
	}

	/**
	 * @param array $params
	 */
	public function updatePlan( $params )
	{
		error_log("Updating Plan");
		error_log(print_r($params, true));

		$response = $this->db->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['pid']),
				'name' => array( AmazonDynamoDB::TYPE_STRING => $params['plan']['name'])
			)
		));

		error_log("Update Plan Response:");
		error_log(print_r($response, true));
	}
}
?>
