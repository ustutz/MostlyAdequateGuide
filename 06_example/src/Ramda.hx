package;

/**
 * ...
 * @author Urs Stutz
 */
class Ramda {

	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }
	public static function compose3<A,B,C,D>( f:C->D, g:B->C, h:A->B ):A->D 						{ return function( x:A ) return f( g( h( x ))); }
	public static function compose4<A,B,C,D,E>( f:D->E, g:C->D, h:B->C, i:A->B ):A->E 				{ return function( x:A ) return f( g( h( i( x )))); }
	public static function compose5<A,B,C,D,E,F>( f:E->F, g:D->E, h:C->D, i:B->C, j:A->B ):A->F 	{ return function( x:A ) return f( g( h( i( j( x ))))); }
	
	public static function prop<T>( p:String, obj:T ):Dynamic {
		return Reflect.getProperty( obj, p );
	}
}