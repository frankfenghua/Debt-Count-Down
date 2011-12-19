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
	 * @return string
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
	 * @return boolean
	 */
	public function deletePlan( $params )
	{
		$sth = $this->db->prepare("DELETE FROM plans WHERE pid = ?");
		$sth->execute(array($params['pid']));

		return true;
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
	 * @return string
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
	 * @return string
	 */
	public function updatePlan( $params )
	{
		$sth = $this->db->prepare("UPDATE plans SET name = ? WHERE pid = ?");
		$sth->execute(array($params['plan']['name'], $params['plan']['pid']));
	}
}
?>