package om.input;

import js.html.midi.MIDIInput;
import js.html.midi.MIDIInputMap;
import js.html.midi.MIDIMessageEvent;
import om.audio.MIDI;

@:enum abstract Channel(Int) from Int to Int {

	var F1 = 2;
	var F2 = 3;
	var F3 = 4;
	var F4 = 5;
	var F5 = 6;
	var F6 = 8;
	var F7 = 9;
	var F8 = 12;
	var F9 = 13;

	var K1 = 14;
	var K2 = 15;
	var K3 = 16;
	var K4 = 17;
	var K5 = 18;
	var K6 = 19;
	var K7 = 20;
	var K8 = 21;
	var K9 = 22;

	var B1_1 = 23;
	var B1_2 = 33;

	var B2_1 = 24;
	var B2_2 = 34;

	var B3_1 = 25;
	var B3_2 = 35;

	var B_REC = 44;
	var B_PLAY = 45;
	var B_STOP = 46;
	var B_PREV = 47;
	var B_NEXT = 48;
	var B_LOOP = 49;

	// TODO …
}

class NanoKontrol {

	public static inline var MANUFACTURER = 'KORG INC.';
	public static inline var NAME = 'nanoKONTROL MIDI 1';

	public dynamic function onInput( channel : Channel, value : Int ) {}

	public var input : MIDIInput;

	public function new( input : MIDIInput ) {
		this.input = input;
		input.onmidimessage = handleMessage;
	}

	public function handleMessage( e : MIDIMessageEvent ) {
		var a = e.data;
		// trace(a);
		onInput( a[1], a[2] );
	}

	public static function getDevice( midiInput : MIDIInputMap ) : NanoKontrol {
		var inputs = midiInput.values();
		while( true ) {
			var input = inputs.next();
			if( input.value == null && input.done ) {
				break;
			} else if( input.value.name == NAME ) {
				return new NanoKontrol( cast input.value );
			}
		}
		return null;
	}

	public static inline function requestDevice() : Promise<NanoKontrol> {
		return js.Browser.navigator.requestMIDIAccess().then( midi -> {
			return NanoKontrol.getDevice( midi.inputs );
		});
	}

}
