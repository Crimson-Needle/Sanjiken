///@desc Returns the cross product of two 3d vectors
///@arg x1
///@arg y1
///@arg z1
///@arg x2
///@arg y2
///@arg z2
{
	var _x1 = argument0;
	var _y1 = argument1;
	var _z1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _z2 = argument5;
	
	var _vec;
	_vec[X] = (_y1 * _z2) - (_z1 * _y2);
	_vec[Y] = (_z1 * _x2) - (_x1 * _z2);
	_vec[Z] = (_x1 * _y2) - (_y1 * _x2);
	
	return _vec;
}