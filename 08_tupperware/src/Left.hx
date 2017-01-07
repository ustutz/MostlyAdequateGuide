package;

/**
 * ...
 * @author Urs Stutz
 */
class Left<A> {

	var value:A;

	public static function of<A>( x:A ):Left<A> {
		return new Left( x );
	}
	
	function new( x:A ) {
		this.value = x;
	}
	
	public function map<B>( f:A->B ):Left<A> {
		return this;
	}
}