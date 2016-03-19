package om.input;

import js.Browser.document;
import js.html.DragEvent;
import js.html.Element;
//import js.html.FileList;

class FileDropArea implements om.Disposable {

	public dynamic function onEvent( e : DragEvent ) {}

	public var target(default,null) : Element;
	public var active(default,null) = false;

	public function new( target : Element ) {
		this.target = target;
	}

	public function activate() {

		if( active )
			return;

		target.addEventListener( 'drag', handleDrag, false );
		target.addEventListener( 'dragstart', handleDragStart, false );
		target.addEventListener( 'dragend', handleDragEnd, false );
		target.addEventListener( 'dragover', handleDragOver, false );
		target.addEventListener( 'dragenter', handleDragEnter, false );
		target.addEventListener( 'dragleave', handleDragLeave, false );
		target.addEventListener( 'drop', handleDrop, false );

		active = true;
	}

	public function dispose() {

		if( !active )
			return;

		target.removeEventListener( 'drag', handleDrag );
		target.removeEventListener( 'dragstart', handleDragStart );
		target.removeEventListener( 'dragend', handleDragEnd );
		target.removeEventListener( 'dragover', handleDragOver );
		target.removeEventListener( 'dragenter', handleDragEnter );
		target.removeEventListener( 'dragleave', handleDragLeave );
		target.removeEventListener( 'drop', handleDrop );

		active = false;
	}

	function handleDrag( e : DragEvent ) onEvent(e);
	function handleDragStart( e : DragEvent ) onEvent(e);
	function handleDragEnd( e : DragEvent ) onEvent( e );
	function handleDragLeave( e : DragEvent ) onEvent( e );

	function handleDragOver( e : DragEvent ) {

		e.stopPropagation();
		e.preventDefault();

		onEvent( e );

		return false;
	}

	function handleDragEnter( e : DragEvent ) {

		e.stopPropagation();
		e.preventDefault();

		onEvent( e );

		return false;
	}


	function handleDrop( e : DragEvent ) {

		e.stopPropagation();
    	e.preventDefault();

		//e.dataTransfer.dropEffect = 'copy';
		//var files = e.dataTransfer.files;

		onEvent( e );
	}

}
