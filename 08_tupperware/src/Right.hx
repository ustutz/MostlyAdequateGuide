package;

/**
 * ...
 * @author Urs Stutz
 */
class Right<A> {

	var value:A;

	public static function of<A>( x:A ):Right<A> {
		return new Right( x );
	}
	
	function new( x:A ) {
		this.value = x;
	}
	
	public function map<B>( f:A->B ):Right<B> {
		return Right.of( f( value ));
	}
}