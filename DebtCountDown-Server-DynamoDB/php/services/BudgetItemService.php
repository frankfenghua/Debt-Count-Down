<?
class BudgetItemService
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
		$this->db = new PDO('sqlite:dcd.db');
		$this->db->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
	}

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param array $params
	 */
	public function addItem($params)
	{
		$sth = $this->db->prepare("INSERT INTO budgetItems (name, amount, type) VALUES (?, ?, ?)");
		$sth->execute(array($params['item']['name'], $params['item']['amount'], $params['item']['type']));

		$itemId = $this->db->lastInsertId();

		if( $params['item']['active'] == 'true' )
		{
			$sth = $this->db->prepare("INSERT INTO planBudgetItems (planId, budgetItemId) VALUES (?, ?)");
			$sth->execute(array($params['planId'], $itemId));
		}

		echo '{"pid":"' . $itemId . '"}';
	}

	/**
	 * @param array $params
	 */
	public function deleteItem($params)
	{
		$sth = $this->db->prepare("DELETE FROM planBudgetItems WHERE budgetItemId = ?");
		$sth->execute(array($params['pid']));

		$sth = $this->db->prepare("DELETE FROM budgetItems WHERE pid = ?");
		$sth->execute(array($params['pid']));
	}

	/**
	 * @param array $params
	 */
	public function loadAllItems($params)
	{
		$sth = $this->db->prepare("SELECT bi.pid, name, amount, type, "
			. "CASE WHEN pbi.pid > 0 THEN 'true' ELSE 'false' END AS active "
			. "FROM budgetItems bi "
			. "LEFT OUTER JOIN planBudgetItems pbi ON pbi.budgetItemId = bi.pid "
			. "AND pbi.planId = ?");
		$sth->execute(array($params['planId']));

		$items = $sth->fetchAll();

		echo json_encode($items);
	}

	/**
	 * @param array $params
	 */
	public function updateItem($params)
	{
		$sth = $this->db->prepare("UPDATE budgetItems SET name = ?, amount = ?, type = ? "
			. "WHERE pid = ?");
		$sth->execute(array($params['item']['name'],$params['item']['amount'], $params['item']['type'], $params['item']['pid']));

		if( $params['item']['active'] == 'true' )
		{
			$sth = $this->db->prepare("SELECT pid FROM planBudgetItems WHERE budgetItemId = ? AND planId = ?");
			$sth->execute(array($params['item']['pid'], $params['planId']));
			$pid = $sth->fetch();

			if( !$pid['pid'] )
			{
				$sth = $this->db->prepare("INSERT INTO planBudgetItems (planId, budgetItemId) VALUES (?, ?)");
				$sth->execute(array($params['planId'], $params['item']['pid']));
			}
		}
		else
		{
			$sth = $this->db->prepare("DELETE FROM planBudgetItems WHERE budgetItemId = ? AND planId = ?");
			$sth->execute(array($params['item']['pid'], $params['planId']));
		}
	}
}
?>