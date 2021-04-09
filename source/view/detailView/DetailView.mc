using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

var currentlyOnScreen = 0;
var maxScreens = 2; // Start to count from 0

class DetailView extends WatchUi.View {
    private var cDrawables = {}; // cached drawables
    private var cStrings = {}; // and also cached strings

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.DetailsLayout(dc));

        // Here we cache every resource we will use in this view
        cDrawables[:FirstSectionLabel] = View.findDrawableById("FirstSectionLabel");
        cDrawables[:FirstSectionData] = View.findDrawableById("FirstSectionData");
        cDrawables[:SecondSectionLabel] = View.findDrawableById("SecondSectionLabel");
        cDrawables[:SecondSectionData] = View.findDrawableById("SecondSectionData");

        cStrings[:AverageSpeed] = Rez.Strings.DetailView_AverageSpeed;
        cStrings[:TopSpeed] = Rez.Strings.DetailView_TopSpeed;
        cStrings[:Voltage] = Rez.Strings.DetailView_Voltage;
        cStrings[:BatteryPercentage] = Rez.Strings.DetailView_BatteryPercentage;
        cStrings[:RideTime] = Rez.Strings.DetailView_RideTime;
        cStrings[:Distance] = Rez.Strings.DetailView_Distance;
        cStrings[:SpeedData] = Rez.Strings.DetailView_SpeedData;
        cStrings[:BatteryVoltageData] = Rez.Strings.DetailView_BatteryVoltageData;
        cStrings[:BatteryPercentageData] = Rez.Strings.DetailView_BatteryPercentageData;
        cStrings[:RideDistanceData] = Rez.Strings.DetailView_RideDistanceData;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        
    }

    // Update the view
    function onUpdate(dc) {
        switch (currentlyOnScreen) {
            case 0:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:AverageSpeed]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:TopSpeed]);
                // And values
                cDrawables[:FirstSectionData].setText(Lang.format("$1$ km/h", [WheelData.AverageSpeed]));
                cDrawables[:SecondSectionData].setText(Lang.format("$1$ km/h", [WheelData.TopSpeed]));
                break;
            case 1:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:Voltage]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:BatteryPercentage]);

                cDrawables[:FirstSectionData].setText(Lang.format("$1$ V", [WheelData.BatteryVoltage]));
                cDrawables[:SecondSectionData].setText(Lang.format("$1$ %", [WheelData.BatteryPercentage]));
                break;
            case 2:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:RideTime]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:Distance]);

                cDrawables[:FirstSectionData].setText(WheelData.RideTime);
                cDrawables[:SecondSectionData].setText(Lang.format("$1$ km", [WheelData.RideDistance]));
                break;
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }

    function moveUp() {
        if (currentlyOnScreen == 0) {
            WatchUi.switchToView(new HomeView(), new HomeViewDelegate(), WatchUi.SLIDE_DOWN);
        } else {
            currentlyOnScreen--;
        }
        WatchUi.requestUpdate();
    }

    function moveDown() {
        if (currentlyOnScreen != maxScreens) {
            currentlyOnScreen++;
        }
        WatchUi.requestUpdate();
    }
}