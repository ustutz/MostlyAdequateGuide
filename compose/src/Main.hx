package;
import haxe.ds.ArraySort;
import haxe.ds.ListSort;

/**
 * ...
 * @author Urs Stutz
 */
typedef Car = {
	var name:String;
	var horsepower:Int;
	var dollar_value:Int;
	var in_stock:Bool;
}

class Main {
	
	static function compose2<A,B,C>( f:B->C, g:A->B ):A->C 									{ return function( x:A ) return f( g( x )); }
	static function compose3<A,B,C,D>( f:C->D, g:B->C, h:A->B ):A->D 						{ return function( x:A ) return f( g( h( x ))); }
	static function compose4<A,B,C,D,E>( f:D->E, g:C->D, h:B->C, i:A->B ):A->E 				{ return function( x:A ) return f( g( h( i( x )))); }
	static function compose5<A,B,C,D,E,F>( f:E->F, g:D->E, h:C->D, i:B->C, j:A->B ):A->F 	{ return function( x:A ) return f( g( h( i( j( x ))))); }
	
	static function join<A>( list:List<A>, sep:String ):String 								{ return list.join( sep ); }
	
	static function ftrace<A,B>( tag:A, x:B ):B {
		trace( tag, x );
		return x;
	}
		
	static function id<T>( x:T ):T {
		return x;
	}
	
	static function head<T>( x:Array<T> ):T {
		return x[0];
	}
	
	static function last<T>( x:Array<T> ):T {
		return x[x.length - 1];
	}
	
	static function prop<T>( p:String, obj:T ):Dynamic {
		return Reflect.getProperty( obj, p );
	}
	
	static function add<A,B>( a:A, b:B ):Float { 
		return cast( a, Float) + cast( b, Float);
	}
	
	static function average<T>( xs:List<T> ):Float {
		return Lambda.fold( xs, add.bind( _, _ ), 0 ) / xs.length;
	}
	
	static function toLowerCase<T>( x:T ):String {
		return cast( x, String ).toLowerCase();
	}
	
	static function replace( what:EReg, replacement:String, str:String ):String {
		return what.replace( str, replacement );
	}
	
	static function sortBy<A>( array:Array<A>, f:A->Float ):Array<A> {
		ArraySort.sort( array, function(a, b):Int {
		  if ( f( a ) < f( b )) return -1;
		  else if ( f( a ) > f( b )) return 1;
		  return 0;
		});
		return array;
	}
	
	static function main() {
		
		examples();
		exercises();
	}
	
	static function examples():Void {
		
		////////////////////////////////////////////////////////////////////////
		// Functional husbandry
		
		var toUpperCase = function( x:String ):String {
			return x.toUpperCase();
		}
		
		var exclaim = function( x:String ):String {
			return x + '!';
		}
		
		var shout = compose2( exclaim, toUpperCase );
		
		trace( shout( "send in the clowns" ));
		
		
		
		
		var head = function( x:Array<String> ):String {
			return x[0];
		}
		
		trace( "head(['jumpkick', 'roundhouse', 'uppercut']): " + head(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var reverse = Lambda.fold.bind( _, function( x:String, acc:Array<String> ):Array<String> {
			return [x].concat( acc );
		}, [] );
		
		trace( "reverse(['jumpkick', 'roundhouse', 'uppercut']): " + reverse(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		var last = compose2( head, reverse );
		
		trace( "last(['jumpkick', 'roundhouse', 'uppercut']): " + last(['jumpkick', 'roundhouse', 'uppercut']));

		
		
		
		// previously we'd have to write two composes, but since it's associative, we can give compose as many fn's as we like and let it decide how to group them.
		var lastUpper = compose3(toUpperCase, head, reverse);
		
		trace( "lastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + lastUpper(['jumpkick', 'roundhouse', 'uppercut']));

		var loudLastUpper = compose4(exclaim, toUpperCase, head, reverse);
		
		trace( "loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']): " + loudLastUpper(['jumpkick', 'roundhouse', 'uppercut']));
		
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////
		// Pointfree
		
		var snakeCase = compose2( replace.bind( ~/\s+/ig, "_", _ ), toLowerCase );
		
		trace( "snakeCase( 'Send in the Clowns' ): " + snakeCase( 'Send in the Clowns' ));
		
		
		var stringHead = function( str:String ):String { return str.substr( 0, 1 ); }
		var split = function( str:String, splitter:String ):Array<String> { return str.split( splitter ); }
		
		
		var initials = compose3( join.bind( _, '. '), Lambda.map.bind( _, compose2(toUpperCase, stringHead)), split.bind( _, ' '));
		
		trace( "initials( 'hunter stockton thompson' ): " + initials( 'hunter stockton thompson' ));
		
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////
		// Debugging
		
		var latin = compose2( Lambda.map.bind( _, shout ),  reverse );
		
		trace( "latin( ['frog', 'eyes'] ): " + latin( ['frog', 'eyes'] ));
		
		
		
		var dasherize = compose5( join.bind( _, '-'), Lambda.map.bind( _, toLowerCase.bind( _ )), ftrace.bind('after split', _), split.bind( _, ' ' ), replace.bind( ~/\s{2,}/ig, ' ', _ ));
		
		trace( dasherize('The world is a vampire'));
		
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////
		// Category theory
		
		var g = function( x:String ):Int {
			return x.length;
		}
		
		var f = function( x:Int ):Bool {
			return x == 4;
		}
		
		var isFourLetterWord = compose2( f, g );
		
		trace( "isFourLetterWord( 'Hello' ): " + isFourLetterWord( 'Hello' ));
	}
	
	
	
	static function exercises():Void {
		
		// Example Data
		var c1:Car = { name: "Ferrari FF", horsepower: 660, dollar_value: 700000, in_stock: true };
		var c2:Car = { name: "Spyker C12 Zagato", horsepower: 650, dollar_value: 648000, in_stock: false };
		var c3:Car = { name: "Jaguar XKR-S", horsepower: 550, dollar_value: 132000, in_stock: false };
		var c4:Car = { name: "Audi R8", horsepower: 525, dollar_value: 114200, in_stock: false };
		var c5:Car = { name: "Aston Martin One-77", horsepower: 750, dollar_value: 1850000, in_stock: true };
		var c6:Car = { name: "Pagani Huayra", horsepower: 700, dollar_value: 1300000, in_stock: false };
		
		var cars = [ c1, c2, c3, c4, c5, c6 ];
		
		
		// Exercise 1:
		// ============
		// Use _.compose() to rewrite the function below. Hint: _.prop() is curried.
		var isLastInStock = compose2( prop.bind( 'name', _ ), last );
		
		trace( "isLastInStock( cars ): " + isLastInStock( cars ));
		
		
		// Exercise 2:
		// ============
		// Use _.compose(), _.prop() and _.head() to retrieve the name of the first car.
		var nameOfFirstCar = compose2( prop.bind( 'name', _ ), head );
		
		trace( "nameOfFirstCar( cars ): " + nameOfFirstCar( cars ));
		
		
		// Exercise 3:
		// ============
		// Use the helper function _average to refactor averageDollarValue as a composition.
		var averageDollarValue = compose2( average.bind( _ ), Lambda.map.bind( _, prop.bind( 'dollar_value', _ )));
		
		trace( "averageDollarValue( cars ): " + averageDollarValue( cars ));
		
		
		// Exercise 4:
		// ============
		// Write a function: sanitizeNames() using compose that returns a list of lowercase and underscored car's names: e.g: sanitizeNames([{name: 'Ferrari FF', horsepower: 660, dollar_value: 700000, in_stock: true}]) //=> ['ferrari_ff'].
		
		var underscore = replace.bind( ~/\W+/g, '_', _ ); //<-- leave this alone and use to sanitize
		
		var sanitizeNames = Lambda.map.bind( _, compose3( underscore, toLowerCase, prop.bind( 'name', _)));
		
		trace( sanitizeNames( cars ));
		

		// Bonus 1:
		// ============
		// Refactor availablePrices with compose.
		
		var formatPrice = compose2( Accounting.formatMoney, prop.bind( 'dollar_value', _ ));
		var availablePrices = compose3( join.bind( _, ', ' ), Lambda.map.bind( _, formatPrice ), Lambda.filter.bind( _, prop.bind( 'in_stock', _ )));
		
		trace( "availablePrices( cars ): " + availablePrices( cars ));
		
		
		// Bonus 2:
		// ============
		// Refactor to pointfree. Hint: you can use _.flip().

		var append = function( s1:String, s2:String ):String { return s1 + s2; }
		
		var fastestCar = compose4( 	append.bind( _, ' is the fastest.'),
									prop.bind( 'name', _ ),
									last,
									sortBy.bind( _, prop.bind( 'horsepower', _ )));
									
		
		trace( "fastestCar( cars ): " + fastestCar( cars ));
		
	}
	
}

