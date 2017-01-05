package;
import js.html.Element;
import js.jquery.JQuery;

/**
 * ...
 * @author Urs Stutz
 */
class Impure {

	public static function getJSON( callback:Dynamic, url:String ):Void {
		JQuery.getJSON( url, callback );
	}
	
	public static function appendElements( sel:String, elements:List<Element> ):Void {
		for( element in elements ) {
			new JQuery( sel ).append( element );
		}
	}
	
}