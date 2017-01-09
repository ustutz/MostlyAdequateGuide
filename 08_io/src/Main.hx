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
		paramsExample();
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
		
		trace( io_window.unsafePerformIO());
		
		var io_window_map = io_window.map( function( win ) {
			return win.innerWidth;
		});
		
		trace( io_window_map.unsafePerformIO() );
		
		//var m1 = io_window.map( R.prop.bind( 'location' ));
		//trace( "m1: " + m1.unsafePerformIO() );
		
		//var m2 = io_window.map( R.prop.bind( 'location' )).map( R.prop.bind( 'href' ));
		//trace( "m2: " + m2.unsafePerformIO() );
		
		var m3 = io_window.map( R.prop.bind( 'location' )).map( R.prop.bind( 'href' )).map( R.split.bind( '/' ));
		trace( m3.unsafePerformIO() );
		
		var S = function( selector:String ) {
			return new IO( function() {
				return Browser.document.querySelectorAll( selector );
			});
		}
		
		var s1 = S( '#myDiv' ).map( head ).map( function( div:Element ) {
			return div.innerHTML;
		});
		trace( s1.unsafePerformIO());
		
	}
	
	static function last<T>( x:Array<T> ):T {
		return x[x.length - 1];
	}
	
	static function paramsExample():Void {
		
		////// Our pure library: lib/params.js ///////
		
		// example url from the book
		//var url = IO.of( Browser.window.location.href );
		
		// my test url
		var testUrl = 'http://localhost:2000/index.html?wafflehouse=sweet&t=hs&ia=web';
		var url = IO.of( testUrl );
		
		var toPairs = R.compose2( R.map.bind( R.split.bind( '=' )), R.split.bind( '&' ));
		
		var params = R.compose3( toPairs, last, R.split.bind( '?' )); 
		
		var findParam = function( key:String ):IO<Maybe<Array<String>>> {
			
			//return map(compose(Maybe.of, filter(compose(eq(key), head)), params), url); //js line
			return R.map( R.compose3( Maybe.of, R.filter.bind( R.compose2( R.eq.bind( key ), head )), params ), url );
		}
		
		
		
		
		// tests - to find out what's going on
		
		trace( "url.unsafePerformIO(): " + url.unsafePerformIO());
		
		trace( "toPairs(...): " + toPairs( testUrl ));
		
		trace( "params(...): " + params( testUrl ));
		
		//trace( "compose(...): " + R.compose2( head, params( testUrl )) ); // Error: compose can not be called with a value
		
		var headParamsCompose = R.compose2( head, params );
		trace( "headParamsCompose( testUrl ): " + headParamsCompose( testUrl ));
		
		var headEqWafflehouseCompose = R.compose2( R.eq.bind( 'wafflehouse' ), head );
		var testParams1 = ['wafflehouse','wafflehouse'];
		var testParams2 = ['t','hs'];
		var testParams3 = ['ia','web'];
		trace( "headEqWafflehouseCompose( testParams1 ): " + headEqWafflehouseCompose( testParams1 ));
		trace( "headEqWafflehouseCompose( testParams2 ): " + headEqWafflehouseCompose( testParams2 ));
		trace( "headEqWafflehouseCompose( testParams3 ): " + headEqWafflehouseCompose( testParams3 ));
		
		var filterUrl = R.filter( headEqWafflehouseCompose, params( testUrl ));
		trace( "filter: " + filterUrl );
		
		trace( "Maybe.of( filterUrl ): " + Maybe.of( filterUrl ));
		
		var key = 'wafflehouse';
		var maybeCompose = R.compose3( Maybe.of, R.filter.bind( R.compose2( R.eq.bind( key ), head )), params );
		trace( "maybeCompose( testUrl ): " + maybeCompose( testUrl ));
		
		////// Impure calling code: main.js ///////

		
		// not working :(
		trace( "findParam( 'searchTerm' ).unsafePerformIO(): " + findParam( 'searchTerm' ).unsafePerformIO() );
		// Maybe([['searchTerm', 'wafflehouse']])
		
	}
}

