package;

import neko.Lib;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static function main() {
		
		var sayHello = function():String {
			return "Hello";
		}
		
		trace( "fn1( sayHello ): " + fn1( sayHello ));
		
		trace( "fn2( Std.string, 12 ): " + fn2( Std.string, 12 ));
		
		var add = function( a:Float, b:Float ):Float {
			return a + b;
		}
		
		trace( "fn3( add, 1, 2 ): " + fn3( add, 1, 2 ));
		
	}
	
	static function fn1<A>( f:Void->A ):A {
		return f();
	}
	
	static function fn2<A,B>( f:A->B, x:A ):B {
		return f( x );
	}
	
	static function fn3<A,B,C>( f:A->B->C, x:A, y:B ):C {
		return f( x, y );
	}
	
	
}