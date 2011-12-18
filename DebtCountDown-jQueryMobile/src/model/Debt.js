function DebtVO()
{
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------

	this.active = false;

	this.apr = 0.0

	this.balance = 0.0;

	this.bank = "";

	/**
	 * @private
	 */
	this.pid = 0;

	this.name = "";


	 /**
	  * @private
	  */
	this.planId = 0;

	this.paymentRate = 0.0;

	//-------------------------------------------------------------------------
	//
	// Methods
	//
	//-------------------------------------------------------------------------

	/**
	 * @returns float
	 */
	this.estimateMinPayment = function()
	{
		var retval = 0.0;
		var rate = 0.0;
		
		// 3% is the highest I've seen
		rate = 3 / 100;
		
		retval = Math.floor(this.balance * rate);
		
		return retval;
	}

	/**
	 * @return float
	 */
	this.getMinPayment = function()
	{
		var min = this.balance * this.paymentRate;
			
		// make no payment less than $15
		if( min < 15 )
			min = 15;
		
		return min;
	};

	/**
	 * @param json
	 */
	this.fromJSON = function(json)
	{
		this.active = /^true$/i.test(json.active);
		this.apr = parseFloat(json.apr);
		this.balance = parseFloat(json.balance);
		this.pid = parseInt(json.pid);
		this.name = json.name;
		this.planId = parseInt(json.planId);
		this.paymentRate = parseFloat(json.paymentRate);
	};
}