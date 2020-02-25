///@desc sest the specified camera object to be the main camera object
///@arg object
{
	var _o = argument0;
	
	if (!instance_exists(_o))
		return false;
		
	g.mainCameraObject = _o;
	return true;
}