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
	
	public static function sconcat( s1:String, s2:String ):String {
		return s1 + s2;
	}
	
	public static function match( rx:EReg, str:String ):Array<String> {
		
		var matches = new Array<String>();
		
		if ( rx.match( str )) {
			
			var i = 0;
			var isError = false;
			var matchedString = "";
			
			while ( !isError ) {
				
				try {
					matchedString = rx.matched( i );
				} catch ( msg:String ) {
					isError = true;
				}
				
				if( !isError ) {
					
					var pos = 0;
					do {
						pos = str.indexOf( matchedString, pos );
						if( pos != -1 ) {
							matches.push( matchedString );
							pos += matchedString.length;
						}
					} while ( pos != -1 );
				}
				i++;
			}
			
		}
		
		return matches;
	}
	
	public static function prop<T>( p:String, obj:T ):Dynamic {
		return Reflect.getProperty( obj, p );
	}
}