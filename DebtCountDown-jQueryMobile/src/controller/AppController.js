var cafescribe = cafescribe || {};
cafescribe.controller = cafescribe.controller || {};
cafescribe.controller.appController = cafescribe.controller.appController || {};

//-----------------------------------------------------------------------------
//
// Methods
//
//-----------------------------------------------------------------------------

cafescribe.controller.appController.changePage = function (page)
{
	$.mobile.changePage(page);
};