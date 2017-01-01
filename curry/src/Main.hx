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
		
	}
	
}