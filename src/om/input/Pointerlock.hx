package om.input;

import js.Browser.document;
import js.Browser.console;
import js.html.Element;
import js.html.Event;

class Pointerlock {

	public static inline function isLocked() : Bool{
		return document.pointerLockElement != null;
	}

	public static function requestPointerlock( ?element : Element ) : Promise<Element> {
		if( element == null ) element = document.body;
		return new Promise( function(resolve,reject){
			var handleChange : Event->Void = null;
			var handleError : Event->Void = null;
			handleChange = function(e) {
				document.removeEventListener( 'pointerlockerror', handleError );
				resolve( element );
			}
			handleError = function(e) {
				document.removeEventListener( 'pointerlockchange', handleChange );
				reject( e );
			}
			document.addEventListener( 'pointerlockchange', handleChange, { once : true } );
			document.addEventListener( 'pointerlockerror', handleError, { once : true } );
			element.requestPointerLock();
		});
	}

	public static inline function exitPointerlock(){
		document.exitPointerLock();
	}

}
