App = new Ext.Application({
    name: "App",

    launch: function() {
        this.views.viewport = new this.views.Viewport();
		this.views.managePlans = this.views.viewport.down('#managePlans');
		this.views.manageDebts = this.views.viewport.down('#manageDebts');
		this.views.planEdit = this.views.viewport.down('#planEdit');
    }
});