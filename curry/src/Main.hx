package;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		
		currying();
		curryingExcercises();
	}
	
	static function currying():Void {
		
		var match = function( what:EReg, str:String ):Bool {
			return what.match( str );
		}
		
		var replace = function( what:EReg, replacement:String, str:String ):String {
			return what.replace( str, replacement );
		}
		
		var filter = function( f:String->Bool, ary:Array<String> ):Array<String> {
			return ary.filter( f );
		}
		
		trace( "hello world match space: " + match(  ~/\s+/g, 'hello world'));
		
		var hasSpaces = match.bind( ~/\s+/g, _ );
		
		trace( "hasSpaces( 'hello world' ): " + hasSpaces( 'hello world' ));
		
		trace( "hasSpaces( 'spaceless' ): " + hasSpaces( 'spaceless' ));
		
		trace( "filter( hasSpaces, ['tori_spelling', 'tori amos'] ): " + filter( hasSpaces, ['tori_spelling', 'tori amos'] ));
		
		var findSpaces = filter.bind( hasSpaces, _ );
		
		trace( "findSpaces: " + findSpaces );
		
		var noVowels = replace.bind( ~/[aeiouy]/ig, _, _ );
		var censored = noVowels.bind( "*", _ );
		
		trace( "censored( 'Chocolate Rain' ): " + censored( 'Chocolate Rain' ));
	}
	
	static function curryingExcercises():Void {
		
		// Exercise 1
		//==============
		// Refactor to remove all arguments by partially applying the function.
		
		var words = function( str:String ):Array<String> return str.split( ' ' );
		
		trace( "words( 'alpha beta gamma delta' ): " + words( 'alpha beta gamma delta' ));
		
		
		
		// Exercise 1a
		//==============
		// Use map to make a new words fn that works on an array of strings.

		var sentences = Lambda.map.bind( _, words );

		
		
		// Exercise 2
		//==============
		// Refactor to remove all arguments by partially applying the functions.
		
		var filterQs = Lambda.filter.bind( _,  ~/q/i.match.bind( _ ));
		
		trace( "filterQs( ['alpha', 'beta', 'gamma', 'delta'] ): " + filterQs( ['alpha', 'beta', 'gamma', 'delta'] ));
		
		
		
		// Exercise 3
		//==============
		// Use the helper function _keepHighest to refactor max to not reference any
		// arguments.
		
		var keepHighest = function( x:Float, y:Float ):Float {
			return x >= y ? x : y;
		}
		
		var max = Lambda.fold.bind( _, keepHighest, Math.NEGATIVE_INFINITY );
		
		trace( max( [1, 4, 3, 2, 599, 244] ));
		
		
		
		// Bonus 1:
		// ============
		// wrap array's slice to be functional and curried.
		// //[1,2,3].slice(0, 2)
		
		var slice = function( start:Int, end:Int, xs:Array<Int> ):Array<Int> return xs.slice( start, end );
		
		trace( 'slice( 1, 3, [0, 1, 2, 3, 4, 5, 6] ): ' + slice( 1, 3, [0, 1, 2, 3, 4, 5, 6] ));

		
		
		// Bonus 2:
		// ============
		// Use slice to define a function "take" that takes n elements from the beginning of the string. Make it curried.
		// // Result for "Something" with n=4 should be "Some"

		var stringSlice = function( start:Int, end:Int, xs:String ):String return xs.substr( start, end );
		var take = stringSlice.bind( 0, _, _ );
		
		trace( "take( 4, 'Something' ): " + take( 4, 'Something' ));
	}
	
		
}