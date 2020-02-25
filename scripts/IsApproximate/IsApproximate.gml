///@desc Returns true if the specified value is within error range of the approximate value
///@arg value
///@arg approximate_value
///@arg error
{
	var _x = argument0;
	var _a = argument1;
	var _e = argument2;
	
	return (_x > _a - _e || _x < _a + _e);
}