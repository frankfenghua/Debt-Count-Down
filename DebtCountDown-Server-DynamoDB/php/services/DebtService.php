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

		if( $params['active'] == 'true' )
		{
			
		}

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
		$sth = $this->db->prepare("SELECT d.pid, name, bank, balance, apr, "
			. "paymentRate, CASE WHEN pd.pid > 0 THEN 'true' ELSE 'false' END AS active "
			. "FROM debts d "
			. "LEFT OUTER JOIN planDebts pd ON pd.debtId = d.pid AND pd.planId = ?");
		$sth->execute(array($params['planId']));

		$debts = $sth->fetchAll();

		echo json_encode($debts);
	}

	/**
	 * @param array $params
	 */
	public function updateDebt($params)
	{
		error_log(print_r($params,1));
		$sth = $this->db->prepare("UPDATE debts SET name = ?, bank = ?, "
			. "balance = ?, apr = ?, paymentRate = ? WHERE pid = ?");
		$sth->execute(array($params['debt']['name'], $params['debt']['bank'], 
			$params['debt']['balance'], $params['debt']['apr'], $params['debt']['paymentRate']));

		if( $params['debt']['active'] == 'true' )
		{
			// check to see if record already exists
			$sth = $this->db->prepare("SELECT pid FROM planDebts WHERE debtId = ? AND planId = ?");
			$sth->execute(array($params['debt']['pid'], $params['planId']));
			$pid = $sth->fetch();

			if( !$pid['pid'] )
			{
				$sth = $this->db->prepare("INSERT INTO planDebts (planId, debtId) VALUES(?, ?)");
				$sth->execute(array($params['planId'], $params['debt']['pid']));
			}
		}
		else
		{
			$sth = $this->db->prepare("DELETE FROM planDebts WHERE debtId = ? AND planId = ?");
			$sth->execute(array($params['debt']['pid'], $params['planId']));
		}
	}
}
?>