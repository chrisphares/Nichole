using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class NicholeFaceApp extends App.AppBase {

	function initialize() {
		AppBase.initialize();
    }

	// onStart() is called on application start up
	function onStart(state) {
	}

	// onStop() is called when your application is exiting
	function onStop(state) {
	}

	function getInitialView() {
		return [new NicholeFaceView(), new Ui.BehaviorDelegate()];
	}
}