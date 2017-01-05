package;

import js.Lib;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		
		var app = Ramda.compose2( Impure.getJSON.bind( ftrace.bind( 'response', _), _), url );
		
		app( 'cats' );
	}
	
	
	
	
	static function ftrace<A,B>( tag:A, x:B ):B {
		trace( tag, x );
		return x;
	}
	
	static function url( term:String ):String {
		return 'https://api.flickr.com/services/feeds/photos_public.gne?tags=' +
    term + '&format=json&jsoncallback=?';
	}
}