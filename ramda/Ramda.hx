package;
import haxe.ds.Either;
import haxe.ds.Vector;

/**
 * ...
 * @author Urs Stutz
 */
class Ramda {

	public static function add( v1:Float, v2:Float ):Float {
		return v1 + v2;
	}
	
	public static function compose1<A,B>( f:A->B, g:Void->A ):Void->B								{ return function() return f( g()); }
	public static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }
	public static function compose3<A,B,C,D>( f:C->D, g:B->C, h:A->B ):A->D 						{ return function( x:A ) return f( g( h( x ))); }
	public static function compose4<A,B,C,D,E>( f:D->E, g:C->D, h:B->C, i:A->B ):A->E 				{ return function( x:A ) return f( g( h( i( x )))); }
	public static function compose5<A,B,C,D,E,F>( f:E->F, g:D->E, h:C->D, i:B->C, j:A->B ):A->F 	{ return function( x:A ) return f( g( h( i( j( x ))))); }
	
	public static function sconcat( s1:String, s2:String ):String {
		return s1 + s2;
	}
	
	public static function eq<A>( v1:A, v2:A ):Bool {
		return v1 == v2;
	}
	
	public static function filter<A>( pred:A->Bool, filterable:Array<A> ) {
		var a = new Array<A>();
		for( x in filterable )
			if( pred(x) )
				a.push(x);
		return a;
	}
	
	public static function map<A,B>( f:A->B, list:Dynamic ):Dynamic {
		trace( f );
		trace( list );
		if ( list.map != null ) {
			return list.map( f );
		}
		return Lambda.map( list, f );
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
	
	public static function split( sep:String, str:String ):Array<String> {
		return str.split( sep );
	}
}