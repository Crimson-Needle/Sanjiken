///@desc Returns a normalized vector
///@arg x
///@arg y
{
	var _x = argument0;
	var _y = argument1;
	
	var _len = Length2d(_x, _y);
	
	//A vector with a length of 0 can't be normalized
	if (_len == 0) {
		show_debug_message("Vector (" + string(_x) + "," + string(_y) + ") cannot be normalized as it has a length of zero.");
		return undefined;
	}
	
	//Normalize the vector
	var _vec;
	_vec[X] = _x/_len;
	_vec[Y] = _y/_len;
	
	return _vec;
}