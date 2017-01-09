package;

/**
 * ...
 * @author Urs Stutz
 */
class Maybe<A> {

	var value:A;

	public static function of<A>( x:A ):Maybe<A> {
		return new Maybe( x );
	}
	
	function new( x:A ) {
		this.value = x;
	}
	
	function isNothing() {
		return value == null;
	}
	
	public function map<B>( f:A->B ):Maybe<B> {
		return isNothing() ? Maybe.of( null ) : Maybe.of( f( value ));
	}
	
}