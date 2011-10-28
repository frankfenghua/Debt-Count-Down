var cafescribe = cafescribe || {};
cafescribe.model = cafescribe.model || {};
cafescribe.model.plan = function () 
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
	 */
	this.id = 0;
	
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
		this.id = parseInt(json.id);
		this.name = json.name;
		this.expenses = parseFloat(json.expenses);
		this.income = parseFloat(json.income);
	};
};