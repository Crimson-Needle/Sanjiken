///@desc Build a material struct with the specified attributes. Add it to the material map
///@arg name
///@arg albedo
///@arg spec_map		
///@arg	normal_map
///@arg	diffuse_scale
///@arg	spec_scale
///@arg	spec_sharpness
///@arg luminosity
///@arg	reflect_scale
{
	var _mat = array_create(9);
	
	_mat[@ MAT_ALBEDO]			= argument1;
	_mat[@ MAT_SPEC_MAP]		= argument2;
	_mat[@ MAT_NORMAL_MAP]		= argument3;
	_mat[@ MAT_DIFFUSE_SCALE]	= argument4;
	_mat[@ MAT_SPEC_SCALE]		= argument5;
	_mat[@ MAT_SPEC_POWER]		= argument6;
	_mat[@ MAT_LUMINOSITY]		= argument7;
	_mat[@ MAT_REFLECT_SCALE]	= argument8;
	
	ds_map_add(g.materialMap, argument0, _mat);
	return _mat;
}

