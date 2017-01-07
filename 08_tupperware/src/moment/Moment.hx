package moment;

/**
 * ...
 * @author Urs Stutz
 */
class Moment {

	// just a mockup of moment functionality
	public static function parse( s:String, format:String ):DateData { // format is not used
		
		var parsedYear = Std.parseInt( s.substr( 0, 4 ));
		var parsedMonth = Std.parseInt( s.substr( 5, 2 ));
		var parsedDay = Std.parseInt( s.substr( 8, 2 ));
		
		var year = parsedYear == null ? -1 : parsedYear;
		var month = parsedMonth == null ? -1 : parsedMonth;
		var day = parsedDay == null ? -1 : parsedDay;
		
		return new DateData( day, month - 1, year );
	}
	
	public static function diff( date1:DateData, date2:DateData, type:String ):Int { // type is not used
		// just a simple subtraction which may not be correct
		return date1.year - date2.year;
	}
}