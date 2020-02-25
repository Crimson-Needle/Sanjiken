///@arg surface
///@arg x
///@arg y
///@arg z
///@arg size
///@arg draw_mode
///@arg draw_skybox
///@arg only_draw_static
///@arg reverse_culling
{
	var _surf			= argument0;
	var _x				= argument1;
	var _y				= argument2;
	var _z				= argument3;
	var _size			= argument4;
	var _mode			= argument5;
	var _drawSkybox		= argument6;
	var _onlyDrawStatic	= argument7;
	var _recerseCulling	= argument8;
	
	//Temporary surfaces for scene projection
	var _left	= surface_create(_size, _size);
	var _right	= surface_create(_size, _size);
	var _front	= surface_create(_size, _size);
	var _back	= surface_create(_size, _size);
	var _bottom = surface_create(_size, _size);
	var _top	= surface_create(_size, _size);
	
	
	//Setup utility camera projection
	camera_set_proj_mat(g.utilityCamera, g.squareProjMat);
		
	//LEFT
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x+1,_y,_z,0,0,1));
	ProjectOntoSurface(_left, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);
	
	//RIGHT
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x-1,_y,_z,0,0,1));
	ProjectOntoSurface(_right, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);
	
	//FRONT
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x,_y+1,_z,0,0,1));
	ProjectOntoSurface(_front, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);
	
	//BACK
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x,_y-1,_z,0,0,1));
	ProjectOntoSurface(_back, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);
	
	//BOTTOM
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x,_y,_z-1,0,1,0));
	ProjectOntoSurface(_bottom, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);
	
	//TOP
	camera_set_view_mat(g.utilityCamera, matrix_build_lookat(_x,_y,_z,_x,_y,_z+1,0,-1,0));
	ProjectOntoSurface(_top, _mode, g.utilityCamera, _drawSkybox, _onlyDrawStatic, _recerseCulling);


	//Pack cube map
	surface_set_target(_surf);
	
		draw_clear_alpha(0,1);
	
		CameraPrepare2d(g.utilityCamera, _size*4, _size*2);
		camera_apply(g.utilityCamera);
	
		draw_surface(_left,		0, _size);
		draw_surface(_right,	_size*2, _size);
		draw_surface(_front,	_size, _size);
		draw_surface(_back,		_size, 0);
		draw_surface(_bottom,	0, 0);
		draw_surface(_top,		_size*2, 0);
	
	surface_reset_target();
	
	//Reset drawing back to main camera
	camera_apply(g.mainCamera);
	
	//Cleanup
	surface_free(_left);
	surface_free(_right);
	surface_free(_front);
	surface_free(_back);
	surface_free(_bottom);
	surface_free(_top);
}