///@desc Returns the length of the specified 3d vector
///@arg x
///@arg y
///@arg z
{
	var _x = argument0;
	var _y = argument1;
	var _z = argument2;
	
	var _2d = sqrt(sqr(_x) + sqr(_y));
	var _3d = sqrt(sqr(_2d) + sqr(_z));
	
	return _3d;
}