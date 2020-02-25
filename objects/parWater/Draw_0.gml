{
	event_inherited();

	shader_set(shdWater);

#region Set Shadder Uniforms
	
	//Booleans
	shader_set_uniform_i(g.u_water_useNormalMap,	1);
	
	//External information
	shader_set_uniform_f(g.u_water_time,			g.time);
	shader_set_uniform_f(g.u_water_viewFar,			g.viewFar);
	shader_set_uniform_f(g.u_water_screenWidth,		view_wport);
	shader_set_uniform_f(g.u_water_screenHeight,	view_hport);
	shader_set_uniform_f(g.u_water_cameraPos,		CameraGetX(), CameraGetY(), CameraGetZ());
	shader_set_uniform_f(g.u_water_noiseTexelSize,	1/sprite_get_width(sprNoise), 1/sprite_get_height(sprNoise));
	shader_set_uniform_i(g.u_water_numberOfLights,	min(MAX_LIGHTS, instance_number(objPointLight)));
	
	//Water attributes
	shader_set_uniform_f(g.u_water_waterColor,		color_get_red(waterColor)/255, color_get_green(waterColor)/255, color_get_blue(waterColor)/255);
	shader_set_uniform_f(g.u_water_highlightColor,	color_get_red(highlightColor)/255, color_get_green(highlightColor)/255, color_get_blue(highlightColor)/255);
	shader_set_uniform_f(g.u_water_fogColor,		color_get_red(fogColor)/255, color_get_green(fogColor)/255, color_get_blue(fogColor)/255);
	
	shader_set_uniform_f(g.u_water_specScale,		2.0);
	shader_set_uniform_f(g.u_water_specPower,		1024);
	shader_set_uniform_f(g.u_water_reflectScale,	0.5);
	shader_set_uniform_f(g.u_water_edgeDepth,		edgeDepth);
	shader_set_uniform_f(g.u_water_scrollx,			xscroll);
	shader_set_uniform_f(g.u_water_scrolly,			yscroll);
	shader_set_uniform_f(g.u_water_noisew,			noisew);
	shader_set_uniform_f(g.u_water_noiseh,			noiseh);
	shader_set_uniform_f(g.u_water_normalw,			noisew);
	shader_set_uniform_f(g.u_water_normalh,			noiseh);
	
	shader_set_uniform_f(g.u_water_colorizeDepth,		colorizeDepth);
	shader_set_uniform_f(g.u_water_colorizeDepthRange,	colorizeDepthRange);
	shader_set_uniform_f(g.u_water_fogDepth,			fogDepth);
	shader_set_uniform_f(g.u_water_fogDepthRange,		fogDepthRange);
	
	//Point Light Arrays
	shader_set_uniform_f_array(g.u_water_lightx,	g.lightx);
	shader_set_uniform_f_array(g.u_water_lighty,	g.lighty);
	shader_set_uniform_f_array(g.u_water_lightz,	g.lightz);
	
	shader_set_uniform_f_array(g.u_water_lightr,	g.lightr);
	shader_set_uniform_f_array(g.u_water_lightg,	g.lightg);
	shader_set_uniform_f_array(g.u_water_lightb,	g.lightb);
	
	shader_set_uniform_f_array(g.u_water_lightRange,		g.lightRange);
	shader_set_uniform_f_array(g.u_water_lightIntensity,	g.lightIntensity);
	
	//Texture Maps
	texture_set_stage(g.u_water_screen,		surface_get_texture(g.screen));
	texture_set_stage(g.u_water_depthMap,	surface_get_texture(g.depthMap));
	texture_set_stage(g.u_water_noiseMap,	sprite_get_texture(sprNoise, 0));
	texture_set_stage(g.u_water_normalMap,	sprite_get_texture(sprNoise, 1));
	texture_set_stage(g.u_water_cubeMap,	surface_get_texture(objCubeMap.cubeMap));

#endregion

	//Draw water
	matrix_set(matrix_world, matrix_build(x,y,z,xrot,yrot,zrot,xscale,yscale,zscale));
		vertex_submit(vbuff, pr_trianglelist, -1);
	matrix_set(matrix_world, matrix_build_identity());
	
	shader_reset();

}