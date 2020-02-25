///@desc Copy the contents of a ds_list into an array. Return the array address.
///@arg list
{
	var _list = argument0;
	
	var _array = array_create(ds_list_size(_list));
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		_array[@ _i] = _list[| _i];
	}
	
	return _array;
	
}
