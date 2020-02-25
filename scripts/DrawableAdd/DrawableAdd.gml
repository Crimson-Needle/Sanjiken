///@desc For use with drawable instances. Create a drawable and add it to the drawable list.
///@arg vertex_buffer
///@arg material
///@arg cast_shadows
///@arg recieve_shadows
///@arg x
///@arg y
///@arg z
///@arg xrot
///@arg yrot
///@arg zrot
///@arg xscale
///@arg yscale
///@arg zscale
{
	var _drawable = array_create(13);
	
	_drawable[@ DRAWABLE_VBUFF]				= argument0;
	_drawable[@ DRAWABLE_MATERIAL]			= argument1;
	_drawable[@ DRAWABLE_CAST_SHADOWS]		= argument2;
	_drawable[@ DRAWABLE_RECIEVE_SHADOWS]	= argument3;
										
	_drawable[@ DRAWABLE_LOCAL_X]			= argument4;
	_drawable[@ DRAWABLE_LOCAL_Y]			= argument5;
	_drawable[@ DRAWABLE_LOCAL_Z]			= argument6;
	_drawable[@ DRAWABLE_LOCAL_XROT]		= argument7;
	_drawable[@ DRAWABLE_LOCAL_YROT]		= argument8;
	_drawable[@ DRAWABLE_LOCAL_ZROT]		= argument9;
	_drawable[@ DRAWABLE_LOCAL_XSCALE]		= argument10;
	_drawable[@ DRAWABLE_LOCAL_YSCALE]		= argument11;
	_drawable[@ DRAWABLE_LOCAL_ZSCALE]		= argument12;
	
	ds_list_add(drawableList, _drawable);
	
	return _drawable;
}