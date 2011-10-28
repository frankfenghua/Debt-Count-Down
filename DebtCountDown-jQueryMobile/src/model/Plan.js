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
		var item = jQuery.parseJSON(json);
		this.id = parseInt(item.id);
		this.name = item.name;
		this.expenses = parseFloat(item.expenses);
		this.income = parseFloat(item.income);
	};
};