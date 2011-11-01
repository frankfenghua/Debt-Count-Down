var cafescribe = cafescribe || {};
cafescribe.controller = cafescribe.controller || {};

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

cafescribe.controller.appController = new AppController();