///@desc Step the starting value towards the ending value without exceding it.
///@arg value
///@arg destination
///@arg delta
{
	var _start	= argument0;
	var _end	= argument1;
	var _delta	= argument2;
	
	if (_end == _start)
		return 0;
	
	if (_start < _end)
		return min(_start + abs(_delta), _end);
	
	if (_start > _end)
		return max(_start - abs(_delta), _end);
}