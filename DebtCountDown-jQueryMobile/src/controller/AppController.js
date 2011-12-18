var dcd = dcd || {};
dcd.controller = dcd.controller || {};

function AppController()
{
	//-----------------------------------------------------------------------------
	//
	// Methods
	//
	//-----------------------------------------------------------------------------

	this.changePage = function (page)
	{
		$.mobile.changePage(page);
	};
};

dcd.controller.appController = new AppController();