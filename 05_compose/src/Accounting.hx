package;

/**
 * ...
 * @author Urs Stutz
 */
// Just a dummy library that places a $ in front of the value
// To use real formating of the values use something like
// thx.format - https://github.com/fponticelli/thx.format

class Accounting {

	public static function formatMoney<A>( number:A ):Dynamic {
		
		if ( Std.is( number, Array )) {
			return Lambda.map( cast( number ), formatMoneyValue );
		}
		
		if ( Std.is( number, Float ) || ( Std.is( number, Int ))) {
			return formatMoneyValue( cast( number ));
		}
		
		if ( Std.is( number, Int )) {
			return formatMoneyValue( cast( number ));
		}
		
		return "";
	}
	
	static function formatMoneyValue( number:Float ):String {
		return Std.string( "$" + number );
	}
}