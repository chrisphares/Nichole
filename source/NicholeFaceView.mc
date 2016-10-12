using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class NicholeFaceView extends Ui.WatchFace {

	var showOther = false;
	var secString = "";
	var batString = "";

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

			var battery = sysStats.battery;
			batString = Lang.format("$1$",[battery.format("%01.0i")]) + '%';
		}

		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
		dc.drawText(175, 78, Gfx.FONT_NUMBER_THAI_HOT, minString, Gfx.TEXT_JUSTIFY_RIGHT);
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
		dc.drawText(175, 6, Gfx.FONT_NUMBER_THAI_HOT, hourString, Gfx.TEXT_JUSTIFY_RIGHT);
		dc.drawText(179, 119, Gfx.FONT_MEDIUM, secString, Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawText(202, 6, Gfx.FONT_SMALL, batString, Gfx.TEXT_JUSTIFY_RIGHT);
	}

	function onExitSleep() {
		showOther = true;
	}

	function onEnterSleep() {
		showOther = false;
		Ui.requestUpdate();
	}
}