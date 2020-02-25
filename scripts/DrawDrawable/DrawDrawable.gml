///@arg drawable
///@arg draw_mode
///@arg world_matrix
{
	var _drawable		= argument0;
	var _mode			= argument1;
	var _worldMatrix	= argument2;
	
	
	//Get drawable data
	var _vbuff		= _drawable[DRAWABLE_VBUFF];
	var _mat		= _drawable[DRAWABLE_MATERIAL];


	//Build the drawable's local transformation matrix
	var _localMatrix = matrix_build(
		_drawable[DRAWABLE_LOCAL_X],		_drawable[DRAWABLE_LOCAL_Y],		_drawable[DRAWABLE_LOCAL_Z],
		_drawable[DRAWABLE_LOCAL_XROT],		_drawable[DRAWABLE_LOCAL_YROT],		_drawable[DRAWABLE_LOCAL_ZROT],
		_drawable[DRAWABLE_LOCAL_XSCALE],	_drawable[DRAWABLE_LOCAL_YSCALE],	_drawable[DRAWABLE_LOCAL_ZSCALE]
	);
	
	
	//Draw the drawable with the specified draw mode
	matrix_set(matrix_world, matrix_multiply(_localMatrix, _worldMatrix));
	
		switch (_mode) {
			case DRAW_MATERIAL:
				DrawVbuffMaterial(_vbuff, _mat);
			break;
		
			case DRAW_VIEW_DEPTH:
				DrawVbuffViewDepth(_vbuff);
			break;
		
			case DRAW_VIEW_DISTANCE:
				DrawVbuffViewDistance(_vbuff);
			break;
		}
		
	matrix_set(matrix_world, matrix_build_identity());
	
}