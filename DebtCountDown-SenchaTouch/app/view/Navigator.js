Ext.define('DCD.view.Navigator', {
	extend: 'Ext.NavigationView',
	id: 'Navigator',

	config: {
		fullscreen: true
	},

	 // @private
    doSetActiveItem: function(activeItem, oldActiveItem) {
    	console.log('doSetActiveItem');

        var me = this,
            navigationBar = me.getNavigationBar(),
            layout = me.getLayout(),
            animation = layout.getAnimation() && layout.getAnimation().isAnimation && this.isPainted(),
            pushFn = (animation) ? 'pushTitleAnimated' : 'push',
            popFn = (animation) ? 'popTitleAnimated' : 'pop',
            title;


        if (!activeItem) {
            return;
        }


        title = activeItem.getInitialConfig().title;


        //if we are not popping a view, then add it to the stack
        if (!me.popping) {
            me.push(activeItem);
            me.fireEvent('push', this, activeItem);
        } else {
            me.fireEvent('pop', this, activeItem);
        }


        if (navigationBar) {
            //if there is a previous item in the stack, then we must show the backbutton
            //else we should just hide it
            if (me.getInnerItems().length > 1) {
                if (me.popping) {
                    navigationBar[popFn](title);
                } else {
                    navigationBar[pushFn](title);
                }
            } else {
                if (me.isPainted()) {
                    navigationBar[popFn](title);
                } else {
                    navigationBar.setTitle(title);
                }
            }


            //EXTEND
            navigationBar.rightBox.removeAll();
            if ( activeItem.getRightButton ){
                 navigationBar.rightBox.add(activeItem.getRightButton());
            }


        }


        me.callParent(arguments);
    }
});