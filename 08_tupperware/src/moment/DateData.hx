package moment;

/**
 * ...
 * @author Urs Stutz
 */
class DateData {
	
	public var day:Int;
	public var month:Int;
	public var year:Int;

	public function new( day:Int, month:Int, year:Int ) {
		
		this.year = year;
		this.month = month;
		this.day = day;
	}
	
	public function isValid():Bool {
		return day != -1 && month != -1 && year != -1;
	}
}