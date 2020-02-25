///@desc rotate a vector by the specified angle
///@arg x
///@arg y
///@arg angle
{
	var _x = argument0;
	var _y = argument1;
	var _a = argument2;
	
	var _vec;
	_vec[X] = dcos(_a) * _x + dsin(_a) * _y;
	_vec[Y] = -dsin(_a) * _x + dcos(_a) * _y;
	
	return _vec;
}