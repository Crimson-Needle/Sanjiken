///@desc Get the pitch angle between 2 3d points
///@arg x1
///@arg y1
///@arg x2
///@arg y2
{
	var _x1 = argument0;
	var _y1 = argument1;
	var _x2 = argument2;
	var _y2 = argument3;
	
	var _angle = darctan2(_y1-_y2, _x2-_x1);
	if (_angle < 0) {_angle += 360} //-180 to 180 becomes 0 to 360
	
	return _angle;
}