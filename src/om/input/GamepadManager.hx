package om.input;

import js.Browser.navigator;

class GamepadManager {

	/**
		Current list of detected gamepad devices.
		Call GamepadManager.update() to update.
	*/
	public static var devices(default,null) : Array<js.html.Gamepad>;

    /**
        Returns changed gamepad devices
    */
	public static function update() : Array<js.html.Gamepad> {
		if( devices == null ) devices = new Array<js.html.Gamepad>();
		var pads = navigator.getGamepads();
		var changed = new Array<js.html.Gamepad>();
		for( i in 0...pads.length ) {
			if( pads[i] != devices[i] ) {
				devices[i] = pads[i];
				changed.push( devices[i] );
			}
		}
		return changed;
	}

}
