using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Time.Gregorian as Calendar;

class NicholeFaceView extends Ui.WatchFace {

	var showOther = false;
	var secString = "";
	var batString = "";
	var day = "";
	var date = "";
	var month = "";
	var batColor = Gfx.COLOR_WHITE;
	var batWidth = 0;
	var simpleFont;
	var nichole;
	var deviceSettings;

	function initialize() {
		WatchFace.initialize();
		simpleFont = Ui.loadResource(Rez.Fonts.simple);
		deviceSettings = Sys.getDeviceSettings();
    }

	function onLayout(dc) {
		nichole = new Ui.Bitmap({:rezId=>Rez.Drawables.nichole});
    }

    function onUpdate(dc) {
		View.onUpdate(dc);

		var clockTime = Sys.getClockTime();
		var hourString;
		var minString;
		var string;

		if (deviceSettings.is24Hour == false) {
			hourString = clockTime.hour % 12;
			hourString = (hourString == 0) ? 12 : hourString;
			//am|pm
		}
		else {
			hourString = clockTime.hour;
		}

		hourString = Lang.format("$1$",[hourString.format("%01d")]);

		minString = clockTime.min;
		minString = Lang.format("$1$",[minString.format("%02d")]);

		// color hair
		dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 0, 100, 61);

		// color shirt
		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 61, 100, 100);
		dc.fillRectangle(20, 57, 30, 30);

		// draw Nichole
		// draw faces
	    nichole.draw(dc);

		if (showOther) { //low power mode
			secString = clockTime.sec;
			secString = Lang.format("$1$",[secString]);

			var sysStats = Sys.getSystemStats();

			var now = Time.now();
			var info = Calendar.info(now, Time.FORMAT_LONG);
			day = Lang.format("$1$", [info.day_of_week]);
			month = Lang.format("$1$", [info.month]);
			date = Lang.format("$1$", [info.day]);

			var battery = sysStats.battery;
			batString = Lang.format("$1$",[battery.format("%01.0i")]);

			//draw battery '%'
			dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
			string = "%";
			dc.drawText(125, 128, Gfx.FONT_SYSTEM_XTINY, string, Gfx.TEXT_JUSTIFY_LEFT);
		}
		//draw minutes
		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
		dc.drawText(150, 5, simpleFont, minString, Gfx.TEXT_JUSTIFY_LEFT);

		//draw hours
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(148, 5, simpleFont, hourString, Gfx.TEXT_JUSTIFY_RIGHT);

		//draw seconds
		dc.drawText(200, 65, Gfx.FONT_MEDIUM, secString, Gfx.TEXT_JUSTIFY_RIGHT);

		//draw day | month | date
		string = day + " " + month + " " + date;
		dc.drawText(200, 128, Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_RIGHT);

		//draw battery % value
		dc.drawText(122, 128, Gfx.FONT_SYSTEM_XTINY, batString, Gfx.TEXT_JUSTIFY_RIGHT);
	}

	function onExitSleep() {
		showOther = true;
	}

	function onEnterSleep() {
		clearData();
		Ui.requestUpdate();
	}

	function clearData() {
		secString = "";
		batString = "";
		day = "";
		date = "";
		month = "";
		showOther = false;
		return true;
	}
}