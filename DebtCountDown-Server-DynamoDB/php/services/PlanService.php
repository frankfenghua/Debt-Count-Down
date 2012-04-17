<?php
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

	/**
	 * @private
	 */
	private $queue;

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
	 * @param $params
	 * @return string
	 */
	public function loadFullPlan( $params )
	{
		$retval = "";

		// Here we need to sum up all the expenses and incomes

		// try 
		// {
		// 	$sth = $this->db->prepare("SELECT d.pid, name, bank, balance, apr, paymentRate FROM debts d INNER JOIN planDebts pd ON pd.debtId = d.pid AND pd.planId = ?");
		// 	$sth->execute(array($params['planId']));

		// 	$debts = $sth->fetchAll();

		// 	$sth = $this->db->prepare("SELECT SUM(i.amount) as income, " .
		// 		"SUM(e.amount) AS expenses " .
		// 		"FROM planBudgetItems pbi " .
		// 		"LEFT JOIN budgetItems e ON e.pid = pbi.budgetItemId AND e.type = 'EXPENSE' " .
		// 		"LEFT JOIN budgetItems i ON i.pid = pbi.budgetItemId AND i.type = 'INCOME' " .
		// 		"WHERE pbi.planId = ?");

		// 	$sth->execute(array($params['planId']));

		// 	$budget = $sth->fetch();

		// 	$retset = array('debts' => $debts, 'budget' => $budget);

		// 	$retval = json_encode($retset);
		// } 
		// catch (PDOException $e) 
		// {
		// 	error_log(print_r($e,1));
		// }

		echo $retval;
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
		
		foreach( $response->body->to_stdClass()->Items as $item ) {
			$plan = array("pid" => $item->pid->{AmazonDynamoDB::TYPE_STRING}, "name" => $item->name->{AmazonDynamoDB::TYPE_STRING});
			array_push($plans, $plan);
		}
		
		$retval = json_encode($plans);
	
		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function loadPlan( $params )
	{
		$plan = $this->db->get_item(array(
			'TableName' => 'DCD-Plans',
			'Key' => array(
				'HashKeyElement' => array( AmazonDynamoDB::TYPE_STRING => $params['pid'] )
			)
		));

		echo json_encode($plan);
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
