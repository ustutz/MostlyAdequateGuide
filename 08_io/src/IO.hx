package;

/**
 * ...
 * @author Urs Stutz
 */
class IO<A> {
	
	public var value:Void->A;

	public static function of<A>( x:A ):IO<A> {
		return new IO( function():A {
			return x;
		});
	}
	
	public function new( f:Void->A ) {
		this.value = f;
	}
	
	public function map<E>( f:Dynamic ):IO<Void->A> {
		return new IO( Ramda.compose1( f, value ));
	}
	
	
}