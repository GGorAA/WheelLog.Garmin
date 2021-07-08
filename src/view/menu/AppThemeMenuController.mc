using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var number;
        if (item instanceof String) { number = item.toNumber(); } else { number = item.getId().toNumber(); }
        AppStorage.setValue("AppTheme", number);
    }
}
