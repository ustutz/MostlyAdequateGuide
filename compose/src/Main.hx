package;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		
		var compose = function( f:Dynamic, g:Dynamic, ?h:Dynamic, ?i:Dynamic ) {
			
			if( h == null ) {
				return function( x:Dynamic ) return f( g( x ));
			}
			
			if ( i == null ) {
				return function( x:Dynamic ) return f( g( h( x )));
			}
			return function( x:Dynamic ) return f( g( h( i( x ))));
		}
		
		var toUpperCase = function( x:String ):String {
			return x.toUpperCase();
		}
		
		var exclaim = function( x:String ):String {
			return x + '!';
		}
		
		var shout = compose( exclaim, toUpperCase );
		
		trace( shout( "send in the cowns" ));
		
		
		
		
		var head = function( x:Array<String> ):String {
			return x[0];
		}
		
		trace( "head(['jumpkick', 'roundhouse', 'uppercut']): " + head(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var reverse = Lambda.fold.bind( _, function( x:String, acc:Array<String> ):Array<String> {
			return [x].concat( acc );
		}, [] );
		
		trace( "reverse(['jumpkick', 'roundhouse', 'uppercut']): " + reverse(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var last = compose( head, reverse );
		
		trace( "last(['jumpkick', 'roundhouse', 'uppercut']): " + last(['jumpkick', 'roundhouse', 'uppercut']));

		
		
		
		// previously we'd have to write two composes, but since it's associative, we can give compose as many fn's as we like and let it decide how to group them.
		var lastUpper = compose(toUpperCase, head, reverse);
		
		trace( "lastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + lastUpper(['jumpkick', 'roundhouse', 'uppercut']));

		var loudLastUpper = compose(exclaim, toUpperCase, head, reverse);
		
		trace( "loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']));
	}
}