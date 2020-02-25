///@desc Returns the entry and exit times of a ray on a single axis
///@arg min
///@arg max
///@arg x
///@arg delta
{
	var _min	= argument0;
	var _max	= argument1;
	var _x		= argument2;
	var _delta	= argument3;
	
	var _enter	= (_min - _x)/_delta;
	var _exit	= (_max - _x)/_delta;
	
	var _time	= array_create(2);
	_time[0]	= min(_enter, _exit);
	_time[1]	= max(_enter, _exit);
	
	return _time;
}