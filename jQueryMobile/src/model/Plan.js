function PlanVO() 
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
		
	/**
	 * @private
	 */
	this.expenses = 0.00;
		
	/**
	 * @private
	 */
	this.income = 0.00;
	
	/**
	 * @private
         * This is now a GUID
	 */
	this.pid = "";
	
	/**
	 * @private
	 */
	this.name = "";
	
	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * @param json JSON representation of the model
	 */
	this.fromJSON = function(json)
	{
		this.pid = json.pid;
		this.name = json.name;
		this.expenses = parseFloat(json.expenses);
		this.income = parseFloat(json.income);
	};
};

//cafescribe.model.plan = new PlanVO();