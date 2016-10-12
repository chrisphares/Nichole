using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class NicholeFaceApp extends App.AppBase {

	function initialize() {
		AppBase.initialize();
    }

	function getInitialView() {
		return [new NicholeFaceView(), new Ui.BehaviorDelegate()];
	}
}