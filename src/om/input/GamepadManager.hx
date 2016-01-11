package om.input;

import js.Browser.navigator;

class GamepadManager {

	public static var devices(default,null) = new Array<js.html.Gamepad>();

    /**
        Returns changed gamepad devices
    */
	public static function update() : Array<js.html.Gamepad> {
		var rawGamepads = navigator.getGamepads();
		var changed = new Array<js.html.Gamepad>();
		for( i in 0...rawGamepads.length ) {
			if( rawGamepads[i] != devices[i] ) {
				devices[i] = rawGamepads[i];
				changed.push( devices[i] );
			}
		}
		return changed;
	}

}
