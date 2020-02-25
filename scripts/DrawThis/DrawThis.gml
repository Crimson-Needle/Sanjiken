///@desc Used by drawable instances to draw themselves with the specified draw mode
///@arg draw_mode
{
	var _mode = argument0;
	
	
	var _entityWorldMatrix = matrix_build(x, y, z, xrot, yrot, zrot, xscale, yscale, zscale);

	for (var _i = 0; _i < ds_list_size(drawableList); _i ++) {
		DrawDrawable(drawableList[| _i], _mode, _entityWorldMatrix);
	}
}