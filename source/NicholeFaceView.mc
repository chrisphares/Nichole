using Toybox.Lang as Lang;
using Toybox.Time as Time;
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

	function initialize() {
		WatchFace.initialize();
    }

	function onLayout(dc) {
		setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onUpdate(dc) {
		View.onUpdate(dc);

		var clockTime = Sys.getClockTime();

		var hourString = clockTime.hour;
		hourString = Lang.format("$1$",[hourString]);

		var minString = clockTime.min;
		minString = Lang.format("$1$",[minString.format("%02d")]);

		if (showOther) {
			secString = clockTime.sec;
			secString = Lang.format("$1$",[secString]);

			var sysStats = Sys.getSystemStats();

			var now = Time.now();
			var info = Calendar.info(now, Time.FORMAT_LONG);
			day = Lang.format("$1$", [info.day_of_week]);
			month = Lang.format("$1$", [info.month]);
			date = Lang.format("$1$", [info.day]);

			var battery = sysStats.battery;
			batString = Lang.format("$1$",[battery.format("%01.0i")]) + '%';
			batWidth = 10 - (battery / 10) + 190;
			if (battery >= 50) {
				batColor = Gfx.COLOR_DK_GREEN;
			}
			else if (battery >= 20) {
				batColor = Gfx.COLOR_YELLOW;
			}
			else {
				batColor = Gfx.COLOR_DK_RED;
			}

			dc.setPenWidth(10);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
	    	dc.drawLine(202, 75, 188, 75);

			dc.setPenWidth(8);
	    	dc.drawLine(188, 75, 186, 75);

			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
	    	dc.drawLine(200, 75, 190, 75);

			dc.setColor(batColor, Gfx.COLOR_TRANSPARENT);
	    	dc.drawLine(200, 75, batWidth, 75);
		}

		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
		dc.drawText(175, 78, Gfx.FONT_NUMBER_THAI_HOT, minString, Gfx.TEXT_JUSTIFY_RIGHT);

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(175, 6, Gfx.FONT_NUMBER_THAI_HOT, hourString, Gfx.TEXT_JUSTIFY_RIGHT);

		dc.drawText(179, 119, Gfx.FONT_MEDIUM, secString, Gfx.TEXT_JUSTIFY_LEFT);

		dc.drawText(202, 6, Gfx.FONT_SMALL, day, Gfx.TEXT_JUSTIFY_RIGHT);
		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
		dc.drawText(202, 23, Gfx.FONT_SMALL, date, Gfx.TEXT_JUSTIFY_RIGHT);
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(202, 40, Gfx.FONT_SMALL, month, Gfx.TEXT_JUSTIFY_RIGHT);

		dc.drawText(202, 82, Gfx.FONT_SYSTEM_XTINY, batString, Gfx.TEXT_JUSTIFY_RIGHT);
	}

	function onExitSleep() {
		showOther = true;
	}

	function onEnterSleep() {
		showOther = false;
		Ui.requestUpdate();
	}
}