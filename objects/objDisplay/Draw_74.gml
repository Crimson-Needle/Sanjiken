///@desc Post Processing
{
	//Setup 2D projection
	var _cam = g.utilityCamera;
	camera_set_view_mat(_cam, g.screenOrthoViewMat);
	camera_set_proj_mat(_cam, g.screenOrthoProjMat);
	
#region Filter Luminance
	shader_set(shdFilterLuminance);
		
	shader_set_uniform_f(u_filterLuminance_threshold, 0.6);
	shader_set_uniform_f(u_filterLuminance_range, 0.2);

	surface_set_target(g.ping);
	
		draw_clear_alpha(0,0);
		camera_apply(_cam);
		
		draw_surface(application_surface, 0, 0);
		
	surface_reset_target();
#endregion


#region Horizontal Blur
	//Horizontal Blur
	shader_set(shdBlurGauss);
	
	shader_set_uniform_i(u_blurGauss_steps, 16);
	shader_set_uniform_f(u_blurGauss_sigma, 0.5);
	shader_set_uniform_f(u_blurGauss_blurAxis, 1, 0);
	shader_set_uniform_f(u_blurGauss_texelSize, 1/view_wport, 1/view_hport);

	surface_set_target(g.pong);
	
		draw_clear_alpha(0,0);
		camera_apply(_cam);
		
		draw_surface(g.ping, 0, 0);
		
	surface_reset_target();
#endregion


#region Vertical Blur
	shader_set_uniform_f(u_blurGauss_blurAxis, 0, 1);

	surface_set_target(g.ping);
	
		draw_clear_alpha(0,0);
		camera_apply(_cam);
		
		draw_surface(g.pong, 0, 0);
		
	surface_reset_target();
#endregion


#region Post Bloom and Draw Screen
	shader_set(shdBloomPost);
	
	shader_set_uniform_f(u_bloomPost_darken, 1.0);
	shader_set_uniform_f(u_bloomPost_intensity, 1);
	shader_set_uniform_f(u_bloomPost_saturation, 1);
	texture_set_stage(u_bloomPost_bloomTexture, surface_get_texture(g.ping));
	
	//Draw the screen
	draw_surface(application_surface, 0, 0);
	
	shader_reset();
#endregion

}