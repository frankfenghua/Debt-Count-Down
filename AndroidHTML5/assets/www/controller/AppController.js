var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function AppController()
{
	//-----------------------------------------------------------------------------
	//
	// Methods
	//
	//-----------------------------------------------------------------------------

	/**
	 * @param {string} page
	 * @param {object} options
	 */
	this.changePage = function (page, options)
	{
		$.mobile.changePage($(page), options);
	};
};

dcd.controller.appController = new AppController();