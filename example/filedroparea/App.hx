
import js.Browser.document;
import js.Browser.window;
import js.html.DivElement;
import js.html.FileList;
import om.input.FileDropArea;

class App {

	/*
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
	*/

    static function main() {

        window.onload = function(){

			var element = document.getElementById( 'file-drop-area' );
			var fileDropArea = new FileDropArea( element );
			fileDropArea.onEvent = function(e) {
				switch e.type {
				case 'dragenter': element.style.background = '#f0f0f0';
				case 'dragleave': element.style.background = '#616161';
				case 'drop':
					var files = e.dataTransfer.files;
					var info = document.getElementById( 'info' );
					for( i in 0...files.length ) {
						var f = files[i];
						var e = document.createDivElement();
						e.textContent = f.name + ' - '+f.lastModifiedDate;
						info.appendChild(e);
					}
					element.style.background = '#73C990';
					haxe.Timer.delay( function() element.style.background = '#616161', 600 );
				}
			}
			fileDropArea.activate();
        }
    }
}
