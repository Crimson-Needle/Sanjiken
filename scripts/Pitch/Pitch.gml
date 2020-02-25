///@desc Get the pitch angle between 2 3d points
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
	
	var _a = Length2d(_x2-_x1, _y2-_y1);
	var _o = _z2-_z1;
	
	var _angle = darctan2(_o,_a);
	if (_angle < 0) {_angle += 360;} //-180 to 180 becomes 0 to 360
	
	return _angle;
}