package;

/**
 * ...
 * @author Urs Stutz
 */
class IO<A> {
	
	public var unsafePerformIO:Void->A;

	public static function of<A>( x:A ):IO<A> {
		return new IO( function():A {
			return x;
		});
	}
	
	public function new( f:Void->A ) {
		this.unsafePerformIO = f;
	}
	
	public function map( f:Dynamic ):IO<Void->A> {
		return new IO( Ramda.compose1( f, unsafePerformIO ));
	}
	
	
}