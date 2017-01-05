package;

import js.Browser;
import js.Lib;
import js.html.Element;
import js.jquery.JQuery;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		new Main();
	}
	
   ////////////////////////////////////////////
    // Utils
    //
	
	function img( url:String ):Element {
		var img = Browser.document.createImageElement();
		img.src = url;
		return img;
	}
	
	function ftrace<A,B>( tag:A, x:B ):B {
		trace( tag + ": " + x );
		return x;
	}
	
	// Workaround function: Haxe Lambda function doesn't recognize json array as iterable
	function makeIterable<T>( array:Array<T> ):Iterable<T> {
		return array;
	}
	
    ////////////////////////////////////////////
    // Pure
	
	function url( term:String ):String {
		return 'https://api.flickr.com/services/feeds/photos_public.gne?tags=' + term + '&format=json&jsoncallback=?';
	}
	
	function new() {
		
		// trace json
		//var app = Ramda.compose2( Impure.getJSON.bind( ftrace.bind( 'response', _ ), _ ), url );
		
		
		var mediaUrl = Ramda.compose2( Ramda.prop.bind( 'm' ), Ramda.prop.bind( 'media' ));
		
		
		// unoptimized first version
		//var srcs = Ramda.compose3( Lambda.map.bind( _, mediaUrl ), makeIterable, Ramda.prop.bind( 'items' ));
		//var images = Ramda.compose2( Lambda.map.bind( _, img ), srcs );

		
		// optimized second version
		var mediaToImg = Ramda.compose2( img, mediaUrl );
		
		var images = Ramda.compose2( Lambda.map.bind( _, mediaToImg ), Ramda.prop.bind( 'items' ));
		
		////////////////////////////////////////////
		// Impure
		
		var renderImages = Ramda.compose2( Impure.appendElements.bind( 'body' ), images );
		var app = Ramda.compose2( Impure.getJSON.bind( renderImages ), url );
		
		app( 'cats' );
		
		//test();
	}
	
	// to test to html output
	function test():Void {
		
		var getTestURLs = function( s:String ):Array<String> {
			return [
				'https://farm1.staticflickr.com/279/31748639490_a2f21fea58_m.jpg',
				'https://farm6.staticflickr.com/5552/31282755894_519c3cf3b6_m.jpg',
				'https://farm1.staticflickr.com/691/32004949241_aa92c68200_m.jpg',
				'https://farm1.staticflickr.com/332/32084419796_0c848201ca_m.jpg',
				'https://farm1.staticflickr.com/654/31974775322_c60fff31ed_m.jpg',
				'https://farm1.staticflickr.com/339/32084201646_fff5829b77_m.jpg',
			];
		}
		
		var testImages = Ramda.compose2( Lambda.map.bind( _, img ), getTestURLs );
		var app = Ramda.compose2( Impure.appendElements.bind( 'body', _ ), testImages );
		
		app( 'test' );
	}
	
}