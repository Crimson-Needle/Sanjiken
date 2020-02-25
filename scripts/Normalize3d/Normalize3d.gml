///@desc Returns a normalized 3d vector
///@arg x
///@arg y
///@arg z
{
	var _x = argument0;
	var _y = argument1;
	var _z = argument2;
	
	var _vec;
	var _len = Length3d(_x, _y, _z);
	
	//A vector with a length of 0 can't be normalized
	if (_len == 0) {
		show_debug_message("Vector (" + string(_x) + "," + string(_y) + "," + string(_z) + ") cannot be normalized as it has a length of zero.");
		_len = 1;
		//return undefined;
	}
	
	//Normalize the vector
	_vec[X] = _x/_len;
	_vec[Y] = _y/_len;
	_vec[Z] = _z/_len;
	
	return _vec;
}