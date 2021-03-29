using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Application.Storage;

class WheelLogGarminApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        Storage.setValue("showVoltageInsteadOfPercentage", true);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new WheelLogGarminView(), new WheelLogGarminDelegate() ];
    }

}
