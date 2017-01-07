package;

import js.Browser;
import js.Lib;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		
		var localStorage = new Array<String>();
		localStorage.push( "sky" );
		localStorage.push( "house" );
		localStorage.push( "tree" );
		
		var getFromStorage = function( key:Int ):Void->String {
			return function():String {
				return localStorage[key];
			}
		}
		
		trace( "getFromStorage(0): " + getFromStorage( 0 ));
		
		var io_window = new IO( function() {
			return Browser.window;
		});
		
		io_window.map( function( win ) {
			return win.innerWidth;
		});
		
		
	}
	
}