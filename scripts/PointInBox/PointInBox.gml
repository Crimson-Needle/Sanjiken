///@arg x
///@arg y
///@arg z
///@arg xmin
///@arg ymin
///@arg zmin
///@arg xmax
///@arg ymax
///@arg zmax
{
	var _x		= argument0;
	var _y		= argument1;
	var _z		= argument2;
	var _xmin	= argument3;
	var _ymin	= argument4;
	var _zmin	= argument5;
	var _xmax	= argument6;
	var _ymax	= argument7;
	var _zmax	= argument8;

	return (
		(_x > _xmin && _x < _xmax) &&
		(_y > _ymin && _y < _ymax) &&
		(_z > _zmin && _z < _zmax)
		);
}