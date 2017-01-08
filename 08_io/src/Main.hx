package;

import js.Browser;
import js.Lib;
import js.html.Element;

/**
 * ...
 * @author Urs Stutz
 */
typedef R = Ramda;
 
class Main {
	
	static function main() {
		localStorage();
		ioExample();
	}
	
	static function localStorage():Void {
		
		var localStorage = new Array<String>();
		localStorage.push( "sky" );
		localStorage.push( "house" );
		localStorage.push( "tree" );
		
		var getFromStorage = function( key:Int ):Void->String { // key is Int because Haxe Arrays are called with Int
			return function():String {
				return localStorage[key];
			}
		}
		
		var getFromStorage0 = getFromStorage( 0 );
		trace( "getFromStorage0: " + getFromStorage0() );
		
		localStorage.splice( 0, localStorage.length ); // clear array
		localStorage.push( "snow" );
		trace( "changed first element of localStorage array to snow.\ngetFromStorage0: " + getFromStorage0());
		
	}
	
	static function head<T>( x:Array<T> ):T {
		return x[0];
	}
	
	static function ioExample():Void {
		
		// Example in the book
		//var io_window = new IO( function() {
			//return Browser.window;
		//});
		
		// the same by using the .of function
		var io_window = IO.of( Browser.window );
		
		trace( io_window.value());
		
		var io_window_map = io_window.map( function( win ) {
			return win.innerWidth;
		});
		
		trace( io_window_map.value() );
		
		//var m1 = io_window.map( R.prop.bind( 'location' ));
		//trace( "m1: " + m1.value() );
		
		//var m2 = io_window.map( R.prop.bind( 'location' )).map( R.prop.bind( 'href' ));
		//trace( "m2: " + m2.value() );
		
		var m3 = io_window.map( R.prop.bind( 'location' )).map( R.prop.bind( 'href' )).map( R.split.bind( '/' ));
		trace( m3.value() );
		
		var S = function( selector:String ) {
			return new IO( function() {
				return Browser.document.querySelectorAll( selector );
			});
		}
		
		var s1 = S( '#myDiv' ).map( head ).map( function( div:Element ) {
			return div.innerHTML;
		});
		trace( s1.value());
		
	}
	
}