///@desc Redraw the scene and all of its drawables onto the target surface from the perspective of the specified camera.
///@arg surface
///@arg draw_mode
///@arg camera
///@arg draw_skybox
///@arg only_draw_static
///@arg reverse_culling
{
	var _surf			= argument0;
	var _mode			= argument1;
	var _cam			= argument2;
	var _drawSkybox		= argument3;
	var _onlyDrawStatic	= argument4;
	var _reverseCulling	= argument5;
	

	surface_set_target(_surf);
		
		camera_apply(_cam);
		draw_clear_alpha(0, 0);
		
		if (_drawSkybox)
			DrawSkybox();
		
		if (_reverseCulling)
			gpu_set_cullmode(cull_clockwise);
		
		//Draw all drawables in the scene
		with (parDrawable) {
			if ((_onlyDrawStatic && static) || !_onlyDrawStatic)
				DrawThis(_mode);
		}
		
		gpu_set_cullmode(cull_counterclockwise);
		
	surface_reset_target();
	
	//Reset drawing back to main camera
	camera_apply(g.mainCamera);
}