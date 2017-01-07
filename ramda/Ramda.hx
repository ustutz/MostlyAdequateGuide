package;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Ramda {

	public static function add( v1:Float, v2:Float ):Float {
		return v1 + v2;
	}
	
	public static function compose1<A>( f, g ) 								{ return function() return f( g()); }
	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }
	public static function compose3<A,B,C,D>( f:C->D, g:B->C, h:A->B ):A->D 						{ return function( x:A ) return f( g( h( x ))); }
	public static function compose4<A,B,C,D,E>( f:D->E, g:C->D, h:B->C, i:A->B ):A->E 				{ return function( x:A ) return f( g( h( i( x )))); }
	public static function compose5<A,B,C,D,E,F>( f:E->F, g:D->E, h:C->D, i:B->C, j:A->B ):A->F 	{ return function( x:A ) return f( g( h( i( j( x ))))); }
	
	public static function sconcat( s1:String, s2:String ):String {
		return s1 + s2;
	}
	
	public static function map<A,B>( f:A->B, list:Array<A> ):Array<B> {
		var v = new Vector<B>( list.length );
		for ( i in 0...list.length )
			v[i] = f( list[i] );
		return v.toArray();
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
	
	public static function prop<A>( p:String, obj:A ):Dynamic {
		return Reflect.getProperty( obj, p );
	}
}