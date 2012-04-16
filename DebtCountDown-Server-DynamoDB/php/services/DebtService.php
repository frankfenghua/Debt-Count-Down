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
		try
		{
			$this->db = new PDO('sqlite:dcd.db');
			$this->db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
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
	public function addDebt($params)
	{
		$retval = '';

		$sth = $this->db->prepare("INSERT INTO debts (name, bank, balance, apr, paymentRate) VALUES (?, ?, ?, ?, ?)");
		$sth->execute(array($params['debt']['name'], $params['debt']['bank'], $params['debt']['balance'], $params['debt']['apr'], $params['debt']['paymentRate']));

		$debtId = $this->db->lastInsertId();

		if( $params['debt']['active'] == 'true' )
		{
			$sth = $this->db->prepare("INSERT INTO planDebts (planId, debtId) VALUES(?, ?)");
			$sth->execute(array($params['planId'], $debtId));
		}

		echo '{"pid":"' . $debtId . '"}';
	}

	/**
	 * @param array $params
	 */
	public function deleteDebt($params)
	{
		$sth = $this->db->prepare("DELETE FROM planDebts WHERE debtId = ?");
		$sth->execute(array($params['pid']));

		$sth = $this->db->prepare("DELETE FROM debts WHERE pid = ?");
		$sth->execute(array($params['pid']));
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