///@arg yaw
///@arg pitch
{
	var _yaw	= argument0;
	var _pitch	= argument1;
	
	return dcos(_yaw) * dcos(_pitch);
}