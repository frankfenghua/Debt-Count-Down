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
		try
		{
			$this->db = new AmazonDynamoDB();

			// $this->db->credentials = array()
			
		}
		catch( PDOException $e )
		{
			print_r($e);
		}
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
		$retval = '';

		try
		{
			$sth = $this->db->prepare("INSERT INTO plans (name) VALUES (?)");
			$sth->execute(array($params['name']));

			$retval = '{"pid":"' . $this->db->lastInsertId() . '"}';
		}
		catch( PDOException $e )
		{
			print_r($e);
		}

		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function deletePlan( $params )
	{
		$sth = $this->db->prepare("DELETE FROM plans WHERE pid = ?");
		$sth->execute(array($params['pid']));
	}

	/**
	 * @param array $params
	 */
	public function importData( $params )
	{
		echo PHP_EOL . PHP_EOL;
		echo "# Adding data to the table..." . PHP_EOL;

		$queue = new CFBatchRequest();
		// $queue->user_credentials($db->credentials);

		$this->db->batch($queue)->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => '101' ),
				'name' => array( AmazonDynamoDB::TYPE_STRING => 'Plan One' )
			)
		));

		$this->db->batch($queue)->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => '102' ),
				'name' => array( AmazonDynamoDB::TYPE_STRING => 'Plan Two' )
			)
		));


		$this->db->batch($queue)->put_item(array(
			'TableName' => 'DCD-Plans',
			'Item' => array(
				'pid' => array( AmazonDynamoDB::TYPE_STRING => '103' ),
				'name' => array( AmazonDynamoDB::TYPE_STRING => 'Plan Three' )
			)
		));

		$response = $this->db->batch($queue)->send();

		print_r($response);
	}
	
	public function allData( $params )
	{
		$response = $this->db->scan(array(
			'TableName' => 'DCD-Plans'
		));

		print_r($response);
	}

	/**
	 * @param $params
	 * @return string
	 */
	public function loadFullPlan( $params )
	{
		$retval = "";

		try 
		{
			$sth = $this->db->prepare("SELECT d.pid, name, bank, balance, apr, paymentRate FROM debts d INNER JOIN planDebts pd ON pd.debtId = d.pid AND pd.planId = ?");
			$sth->execute(array($params['planId']));

			$debts = $sth->fetchAll();

			$sth = $this->db->prepare("SELECT SUM(i.amount) as income, " .
				"SUM(e.amount) AS expenses " .
				"FROM planBudgetItems pbi " .
				"LEFT JOIN budgetItems e ON e.pid = pbi.budgetItemId AND e.type = 'EXPENSE' " .
				"LEFT JOIN budgetItems i ON i.pid = pbi.budgetItemId AND i.type = 'INCOME' " .
				"WHERE pbi.planId = ?");

			$sth->execute(array($params['planId']));

			$budget = $sth->fetch();

			$retset = array('debts' => $debts, 'budget' => $budget);

			$retval = json_encode($retset);
		} 
		catch (PDOException $e) 
		{
			error_log(print_r($e,1));
		}

		echo $retval;
	}

	/**
	 * @return string
	 */
	public function loadAllPlans()
	{
		$retval = "";

		try
		{
			$sth = $this->db->prepare("SELECT pid, name FROM plans");
			$sth->execute();

			$plans = $sth->fetchAll();

			$retval = json_encode($plans);
		}
		catch(PDOException $e)
		{
			print_r($e);
		}

		echo $retval;
	}

	/**
	 * @param array $params
	 */
	public function loadPlan( $params )
	{
		$sth = $this->db->prepare("SELECT pid, name FROM plans WHERE pid = ?");
		$sth->execute(array($params['pid']));
		$plan = $sth->fetch();

		echo json_encode($plan);
	}

	/**
	 * @param array $params
	 */
	public function updatePlan( $params )
	{
		$sth = $this->db->prepare("UPDATE plans SET name = ? WHERE pid = ?");
		$sth->execute(array($params['plan']['name'], $params['plan']['pid']));
	}
}
?>
