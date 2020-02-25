///@arg x
///@arg y
///@arg z
{
	var _x = argument0;
	var _y = argument1;
	var _z = argument2;
	
	var _cam = instance_create_layer(_x, _y, "Cameras", objCamera);
	_cam.z = _z;
	
	return _cam;
}