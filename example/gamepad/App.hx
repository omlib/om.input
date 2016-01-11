
import js.Browser.document;
import js.Browser.window;
import js.html.DivElement;
import om.input.GamepadManager;

private class GamepadView {

    public var element(default,null) : DivElement;

    var gamepad : js.html.Gamepad;
    var axes : DivElement;
    var buttons : DivElement;

    public function new( gamepad : js.html.Gamepad ) {

        this.gamepad = gamepad;

        element = document.createDivElement();
        element.classList.add( 'gamepad' );

        var id = document.createDivElement();
        id.textContent = gamepad.id;
        element.appendChild( id );

        axes = document.createDivElement();
        for( v in gamepad.axes ) {
            var e = document.createDivElement();
            e.textContent = Std.string( v );
            axes.appendChild(e);
        }
        element.appendChild( axes );

        buttons = document.createDivElement();
        for( v in gamepad.buttons ) {
            var e = document.createDivElement();
            e.textContent = Std.string( v.pressed );
            buttons.appendChild(e);
        }
        element.appendChild( buttons );
    }

    public function update() {
        for( i in 0...gamepad.axes.length ) {
            axes.children[i].textContent = i+': '+gamepad.axes[i];
        }
        for( i in 0...gamepad.buttons.length ) {
            var v = gamepad.buttons[i];
            buttons.children[i].textContent = i+': '+v.pressed+' '+v.value;
        }
    }
}

class App {

    static var views = new Array<GamepadView>();

    static function update( time : Float ) {

        window.requestAnimationFrame( update );

        var gamepads = GamepadManager.update();
        var i = 0;
        for( gamepad in gamepads ) {
            if( gamepad == null ) {
                var view = views[i];
                view.element.remove();
                views.splice(i,1);
            } else {
                var view = new GamepadView( gamepad );
                document.body.appendChild( view.element );
                views.push( view );
            }
            i++;
        }
        for( view in views ) view.update();
    }

    static function main() {
        window.onload = function(){
            window.requestAnimationFrame( update );
        }
    }
}
