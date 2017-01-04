package;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }
	static function compose3<A,B,C,D>( f:C->D, g:B->C, h:A->B ):A->D 						{ return function( x:A ) return f( g( h( x ))); }
	static function compose4<A,B,C,D,E>( f:D->E, g:C->D, h:B->C, i:A->B ):A->E 				{ return function( x:A ) return f( g( h( i( x )))); }
	static function compose5<A,B,C,D,E,F>( f:E->F, g:D->E, h:C->D, i:B->C, j:A->B ):A->F 	{ return function( x:A ) return f( g( h( i( j( x ))))); }
	
	static function join<A>( list:List<A>, sep:String ):String 								{ return list.join( sep ); }
	
	static function ftrace<A,B>( tag:A, x:B ):B {
		trace( tag, x );
		return x;
	}
		
	
	static function main() {
		
		////////////////////////////////////////////////////////////////////////
		// Functional husbandry
		
		var toUpperCase = function( x:String ):String {
			return x.toUpperCase();
		}
		
		var exclaim = function( x:String ):String {
			return x + '!';
		}
		
		var shout = compose2( exclaim, toUpperCase );
		
		trace( shout( "send in the clowns" ));
		
		
		
		
		var head = function( x:Array<String> ):String {
			return x[0];
		}
		
		trace( "head(['jumpkick', 'roundhouse', 'uppercut']): " + head(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var reverse = Lambda.fold.bind( _, function( x:String, acc:Array<String> ):Array<String> {
			return [x].concat( acc );
		}, [] );
		
		trace( "reverse(['jumpkick', 'roundhouse', 'uppercut']): " + reverse(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var last = compose2( head, reverse );
		
		trace( "last(['jumpkick', 'roundhouse', 'uppercut']): " + last(['jumpkick', 'roundhouse', 'uppercut']));

		
		
		
		// previously we'd have to write two composes, but since it's associative, we can give compose as many fn's as we like and let it decide how to group them.
		var lastUpper = compose3(toUpperCase, head, reverse);
		
		trace( "lastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + lastUpper(['jumpkick', 'roundhouse', 'uppercut']));

		var loudLastUpper = compose4(exclaim, toUpperCase, head, reverse);
		
		trace( "loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////
		// Pointfree
		
		var replace = function( what:EReg, replacement:String, str:String ):String {
			return what.replace( str, replacement );
		}
		
		var toLowerCase = function( x:String ):String {
			return x.toLowerCase();
		}
		
		var snakeCase = compose2( replace.bind( ~/\s+/ig, "_", _ ), toLowerCase );
		
		trace( "snakeCase( 'Send in the Clowns' ): " + snakeCase( 'Send in the Clowns' ));
		
		
		var stringHead = function( str:String ):String { return str.substr( 0, 1 ); }
		var split = function( str:String, splitter:String ):Array<String> { return str.split( splitter ); }
		
		
		var initials = compose3( join.bind( _, '. '), Lambda.map.bind( _, compose2(toUpperCase, stringHead)), split.bind( _, ' '));
		
		trace( "initials( 'hunter stockton thompson' ): " + initials( 'hunter stockton thompson' ));
		
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////
		// Debugging
		
		//var latin = compose2( Lambda.map.bind( _, shout ),  reverse );
		
		//trace( "latin( ['frog', 'eyes'] ): " + latin( ['frog', 'eyes'] ));
		
		
		
		//var dasherize = compose5( join.bind( _, '-'), toLowerCase.bind( _ ), ftrace.bind('after split', _), split.bind( _, ' ' ), replace.bind( ~/\s{2,}/ig, ' ', _ ));
		
	}
}