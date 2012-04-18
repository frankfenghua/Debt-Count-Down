function BudgetItemVO()
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	this.active = false;

	this.amount = 0.0;

	this.name = '';

	this.pid = '';

	this.type = '';

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @param json
	 */
	this.fromJSON = function(json)
	{
		this.active = /^true$/i.test(json.active);
		this.amount = parseFloat(json.amount);
		this.name = json.name;
		this.pid = json.pid;
		this.type = json.type;
	};
};