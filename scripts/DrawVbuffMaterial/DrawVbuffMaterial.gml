///@arg vertex_buffer
///@arg material
{
	var _vbuff	= argument0;
	var _mat	= argument1;
	
	shader_set(shdMaterial);
	
#region Set Shader Uniforms

	var _cubeMapTexture = -1;
	if (instance_exists(g.activeCubeMapObject))
		_cubeMapTexture = surface_get_texture(g.activeCubeMapObject.cubeMap);

	//Booleans
	shader_set_uniform_i(g.u_material_useCubeMap,			g.useCubeMapReflections && _mat[@ MAT_REFLECT_SCALE] != 0);
	shader_set_uniform_i(g.u_material_useNormalMap,			_mat[@ MAT_NORMAL_MAP] != -1);
	shader_set_uniform_i(g.u_material_recieveShadows,		1);

	//External Data
	shader_set_uniform_f(g.u_material_camPos,					CameraGetX(), CameraGetY(), CameraGetZ());
	shader_set_uniform_f(g.u_material_ambientCol,				color_get_red(g.ambientCol)/255, color_get_green(g.ambientCol)/255, color_get_blue(g.ambientCol)/255);
	shader_set_uniform_i(g.u_material_numberOfLights,			min(MAX_LIGHTS, instance_number(objPointLight)));
	shader_set_uniform_f(g.u_material_viewFar,					g.viewFar);
	
	//Texture Maps			
	shader_set_uniform_f(g.u_material_pointShadowMapTexelSize,	1/surface_get_width(g.pointShadowMap), 1/surface_get_height(g.pointShadowMap));
	
	texture_set_stage(g.u_material_pointShadowMap,			surface_get_texture(g.pointShadowMap));
	texture_set_stage(g.u_material_cubeMap,					_cubeMapTexture);
	texture_set_stage(g.u_material_specMap,					_mat[@ MAT_SPEC_MAP]);
	texture_set_stage(g.u_material_normalMap,				_mat[@ MAT_NORMAL_MAP]);
									
	//Material Properties									
	shader_set_uniform_f(g.u_material_diffuseScale,			_mat[@ MAT_DIFFUSE_SCALE]);
	shader_set_uniform_f(g.u_material_specScale,			_mat[@ MAT_SPEC_SCALE]);
	shader_set_uniform_f(g.u_material_specPower,			_mat[@ MAT_SPEC_POWER]);
	shader_set_uniform_f(g.u_material_luminosity,			_mat[@ MAT_LUMINOSITY]);
	shader_set_uniform_f(g.u_material_reflectScale,			_mat[@ MAT_REFLECT_SCALE]);
							
	//Point Light Arrays							
	shader_set_uniform_f_array(g.u_material_lightx,			g.lightx);
	shader_set_uniform_f_array(g.u_material_lighty,			g.lighty);
	shader_set_uniform_f_array(g.u_material_lightz,			g.lightz);
															
	shader_set_uniform_f_array(g.u_material_lightr,			g.lightr);
	shader_set_uniform_f_array(g.u_material_lightg,			g.lightg);
	shader_set_uniform_f_array(g.u_material_lightb,			g.lightb);
	
	shader_set_uniform_f_array(g.u_material_lightRange,		g.lightRange);
	shader_set_uniform_f_array(g.u_material_lightIntensity, g.lightIntensity);
	
	shader_set_uniform_i_array(g.u_material_lightCastShadows,	g.lightCastShadows);
	shader_set_uniform_i_array(g.u_material_lightSmoothShadows, g.lightSmoothShadows);
	
#endregion

	//Draw the object
	vertex_submit(_vbuff, pr_trianglelist, _mat[@ MAT_ALBEDO]);
	shader_reset();

}