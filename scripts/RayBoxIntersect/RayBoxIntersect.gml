///@desc Tests if the specified ray intersects the specified box. Returns a normalized range from 0 to 1. Returns -1 if no intersection.
///@arg x1
///@arg y1
///@arg z1
///@arg x2
///@arg y2
///@arg z2
///@arg xmin
///@arg ymin
///@arg zmin
///@arg xmax
///@arg ymax
///@arg zmax
{
	var _x1		= argument0;
	var _y1		= argument1;
	var _z1		= argument2;
	var _x2		= argument3;
	var _y2		= argument4;
	var _z2		= argument5;
	var _xmin	= argument6;
	var _ymin	= argument7;
	var _zmin	= argument8;
	var _xmax	= argument9;
	var _ymax	= argument10;
	var	_zmax	= argument11;
	
#region Calculate Entry and Exit Time

	//Get entry and exit times for each axis
	var _time;
	
	_time = AxisIntersectTime(_xmin, _xmax, _x1, _x2-_x1);
	var _xenter	= _time[@ 0];
	var _xexit	= _time[@ 1];
	
	_time = AxisIntersectTime(_ymin, _ymax, _y1, _y2-_y1);
	var _yenter	= _time[@ 0];
	var _yexit	= _time[@ 1];
	
	_time = AxisIntersectTime(_zmin, _zmax, _z1, _z2-_z1);
	var _zenter	= _time[@ 0];
	var _zexit	= _time[@ 1];
	
	//Calculate entry and exit times of ray
	var _enter	= max(_xenter, _yenter, _zenter);
	var _exit	= min(_xexit, _yexit, _zexit);
	
#endregion
	
#region Detect Collision
	
	//If entry time is greater than exit time, then the ray has missed the box
	if (_enter > _exit)
		return -1;
	
	//If entry time is negative, then the ray is going away from the box
	if (_enter  < 0)
		return -1;
		
	//If entry time is larger than 1, then the ray is too short and does not reach the box
	if (_enter > 1)
		return -1;
		
	//Return a range representing the point along the ray at which the intersection occured
	return _enter;
	
#endregion
	
}