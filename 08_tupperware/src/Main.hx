package;

import moment.DateData;
import moment.Moment;
import neko.Lib;

/**
 * ...
 * @author Urs Stutz
 */
typedef R = Ramda;

class Main {
	
	
	static function main() {
		
		containerExample();
		maybeExample();
		maybeUseCases();
		withdrawExample();
		pureErrorHandling();
	}
	
	
	
	
	////////////////////////////////////////////
	// Container
	
	static function containerExample():Void {
		
		trace( "Container.of( 3 ):\n" + Container.of( 3 ));
		trace( "Container.of( 'hotdogs' ):\n" + Container.of( 'hotdogs' ));
		trace( "Container.of( Container.of({ name: 'yoda' })):\n" + Container.of( Container.of({ name: 'yoda' })));
		
		trace( 
			"Container.of( 2 ).map( function( two ):\n" + 
			Container.of( 2 ).map( function( two ) {
				return two + 2;
			})
		);
		
		trace(
			"Container.of( 'flamethrowers' ).map( function( s ):\n" +
			Container.of( 'flamethrowers' ).map( function( s ) {
				return s.toUpperCase();
			})
		);
		
		trace(
			"Container.of( 'bombs' ).map( R.sconcat(' away' )).map( R.prop( 'length' ):\n" +
			Container.of( 'bombs' ).map( R.sconcat.bind( _, ' away' )).map( R.prop.bind( 'length', _ ))
		);
	
	}	
	
	
	
	
	////////////////////////////////////////////
	// Maybe
	
	static function maybeExample():Void {
		
		trace(
			"Maybe.of( 'Malkovich Malkovich' ).map( R.match.bind( ~/a/ig )):\n" +
			Maybe.of( 'Malkovich Malkovich' ).map( R.match.bind( ~/a/ig ))
		);
		
		trace(
			"Maybe.of( null ).map( R.match( ~/a/ig )):\n" +
			Maybe.of( null ).map( R.match.bind( ~/a/ig ))
		);
		
		trace(
			"Maybe.of Boris:\n" +
			Maybe.of( {
				name: 'Boris'
			}).map( R.prop.bind( 'age' )).map( R.add.bind( 10 ))
		);
		
		trace(
			"Maybe.of Dinah:\n" +
			Maybe.of( {
				name: 'Dinah',
				age: 14
			}).map( R.prop.bind( 'age' )).map( R.add.bind( 10 ))
		);
	
	}
	
	static function map<A,B>( f:A->B, any_functor_at_all:Maybe<A> ):Maybe<B> {
		return any_functor_at_all.map( f );
	}
	
	static function saveHead<A>( xs:Array<A> ):Maybe<A> {
		return Maybe.of( xs[0] );
	}
	
	
	
	
	////////////////////////////////////////////
	// Maybe use cases
	
	static function maybeUseCases():Void {
		
		var streetName = R.compose3( map.bind( R.prop.bind( 'street' )), saveHead, R.prop.bind( 'addresses' ));
		
		trace(
			"addresses: []:\n" +
			streetName({
				addresses: []
			})
		);
		
		trace(
			"addresses: [{street: 'Shady Ln.', number: 4201 }]:\n" +
			streetName({
				addresses: [{
					street: 'Shady Ln.',
					number: 4201
				}]
			})
		);
		
	}
	
	
	
	
	////////////////////////////////////////////
	// Withdraw example
	
	static function withdrawExample():Void {
		
		var withdraw = function( amount:Float, account:Account ):Maybe<Account> {
			return account.balance >= amount ?
				Maybe.of( new Account( account.balance - amount )) :
				Maybe.of( null );
		}
		
		var remainingBalance = function( a:Account ):String {
			return 'Your balance is $' + a.balance; 
		}
		
		var updateLedger = function( a:Account ):Account { // <- this function is not implemented here...
			return a;
		}
		
		var finishTransaction = R.compose2( remainingBalance, updateLedger );
		
		var getTwenty = R.compose2( map.bind( finishTransaction ), withdraw.bind( 20 ));
		
		var account1 = new Account( 200 );
		trace(
			"getTwenty( Account( 200 )):\n" +
			getTwenty( account1 )
		);

		var account2 = new Account( 10 );
		trace(
			"getTwenty( Account( 10 )):\n" +
			getTwenty( account2 )
		);
	}
	
	
	
	
	////////////////////////////////////////////
	// Pure Error Handling
	
	static function either<A,B,C>( f:A->C, g:B->C, e:Dynamic ):C {
		
		switch( Type.getClass( e )) {
			case Left:
				return f( e.value );
			case Right:
				return g( e.value );
		}
		return null;
	}
	
	static function id<A>( x:A ):A {
		return x;
	}
	
	static function ttrace<A>( x:A ):Void {
		trace( x );
	}
	
	static function pureErrorHandling():Void {
		
		trace(
			"Right.of( 'rain' ):\n" +
			Right.of( 'rain' ).map( function( str ) {
				return 'b' + str;
			})
		);

		trace(
			"Left.of( 'rain' ):\n" +
			Left.of( 'rain' ).map( function( str ) {
				return 'b' + str;
			})
		);

		trace(
			"Right.of( '{ host, port }' ):\n" +
			Right.of( {
				host: 'localhost',
				port: 80
			}).map( R.prop.bind( 'host' ))
		);
		
		trace(
			"Left.of( 'rain' ):\n" +
			Left.of( 'rolls eyes...' ).map( Ramda.prop.bind( 'host' ))
		);

		
		
		var getAge = function( dateNow:Date, user:User ):Dynamic {
			
			var now = new DateData( dateNow.getDate(), dateNow.getMonth(), dateNow.getFullYear());
			// Because I don't have the moment js library I wrote a little mockup to make part work
			var birthdate = Moment.parse( user.birthdate, 'YYYY-MM-DD' );
			
			if( !birthdate.isValid()) return Left.of( 'Birth date could not be parsed' );
			return Right.of( Moment.diff( now, birthdate, 'years' ));
			
		}
		
		trace(
			"getAge( 2005-12-12 ):\n" +
			getAge( Date.now(), new User( '2005-12-12' ))
		);
		
		trace(
			"getAge( 20010704 ):\n" +
			getAge( Date.now(), new User( '20010704' ))
		);
		
		
		
		
		
		var fortune = Ramda.compose3( Ramda.sconcat.bind( 'If you survive, you will be ' ), Std.string, Ramda.add.bind( 1 ));
		
		var zoltar = Ramda.compose2( map.bind( fortune ), getAge.bind( Date.now() ));
		
		trace(
			"zoltar '2005-12-12':\n" +
			zoltar( new User( '2005-12-12' ))
		);
		trace(
			"zoltar 'balloons!':\n" +
			zoltar( new User( 'balloons!' ))
		);
		
		
		
		
		
		var zoltar2 = Ramda.compose3( ttrace, either.bind( id, fortune ), getAge.bind( Date.now() ));
		
		trace( "zoltar2 '2005-12-12':" );
		zoltar2( new User( '2005-12-12' ));
		
		trace( "zoltar2 'balloons!':" );
		zoltar2( new User( 'balloons!' ));
		
	}
}