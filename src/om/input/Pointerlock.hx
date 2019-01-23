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

			var handleChange : Event->Void;
			var handleError : Event->Void;

			handleChange = function(e) {
				//console.debug(e);
				document.removeEventListener( 'pointerlockchange', handleChange );
				document.removeEventListener( 'pointerlockerror', handleError );
				resolve( element );
			}
			handleError = function(e) {
				//console.debug(e);
				document.removeEventListener( 'pointerlockchange', handleChange );
				document.removeEventListener( 'pointerlockerror', handleError );
				reject( e );
			}

			document.addEventListener( 'pointerlockchange', handleChange, false );
			document.addEventListener( 'pointerlockerror', handleError, false );

			element.requestPointerLock();
		});
	}

}
