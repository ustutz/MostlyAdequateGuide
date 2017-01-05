package;
import js.jquery.JQuery;

/**
 * ...
 * @author Urs Stutz
 */
class Impure {

	public static function getJSON( callback:Dynamic, url:String ):Void {
		JQuery.getJSON( url, callback );
	}
	
	public static function setHTML( sel:String, html:String ):Void {
		new JQuery( sel ).html( html );
	}
	
}