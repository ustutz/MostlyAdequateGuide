package;

/**
 * ...
 * @author Urs Stutz
 */
class Container<A> {

	var value:A;

	public static function of<A>( x:A ):Container<A> {
		return new Container( x );
	}
	
	function new( x:A ) {
		this.value = x;
	}
	
	public function map<B>( f:A->B ):Container<B> {
		return Container.of( f( value ));
	}
}