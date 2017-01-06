package;

import neko.Lib;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	
	static function main() {
		
		////////////////////////////////////////////
		// Container
		
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
			"Container.of( 'bombs' ).map( Ramda.sconcat(' away' )).map( Ramda.prop( 'length' ):\n" +
			Container.of( 'bombs' ).map( Ramda.sconcat.bind( _, ' away' )).map( Ramda.prop.bind( 'length', _ ))
		);
	
		////////////////////////////////////////////
		// Maybe
		
		trace(
			"Maybe.of( 'Malkovich Malkovich' ).map( Ramda.match.bind( ~/a/ig )):\n" +
			Maybe.of( 'Malkovich Malkovich' ).map( Ramda.match.bind( ~/a/ig ))
		);
	}
}