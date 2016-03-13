
import js.Browser.document;
import js.Browser.window;
import js.html.DivElement;
import js.html.FileList;
import om.input.FileDropArea;

class App {

	static function loadFiles( list : FileList, i = 0 ) {
		var file = list[i];
		switch file.type {
		case 'image/jpeg','image/png':
			var reader = new js.html.FileReader();
			reader.onload = function(e){
				var img = document.createImageElement();
				img.src = e.target.result;
				document.body.appendChild(img);
				if( i < list.length )
					loadFiles( list, ++i );
			}
			reader.readAsDataURL( file );
		default:
			trace( 'Invalid file type' );
		}
	}

    static function main() {
        window.onload = function(){
			var fileDropArea = new FileDropArea( document.getElementById( 'file-drop-area' ) );
			fileDropArea.onInput = function(list) {
				trace( list );
				loadFiles( list );
			}
			fileDropArea.start();
        }
    }
}
