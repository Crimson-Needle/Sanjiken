{
	//Don't automatically draw the application surface
	//We want precise control over when and how the application surface is drawn
	application_surface_draw_enable(false);
	
#region DISPLAY SETTINGS

	g.viewFar = 1024;
	g.viewNear = 1;
	
	//Map sizes work best if set to square numbers
	g.cubeMapSize = 512;
	g.pointShadowMapSize = 512;
	
#endregion
	
#region GPU SETTINGS

	gpu_set_zwriteenable(true);
	gpu_set_ztestenable(true);
	gpu_set_alphatestenable(true);
	gpu_set_texrepeat(true);
	gpu_set_cullmode(cull_counterclockwise);
	
#endregion
	
#region CAMERAS

	g.fov			= 60;

	g.mainCamera	= camera_create();
	g.utilityCamera = camera_create();
	
	g.screenProjMat	= matrix_build_projection_perspective_fov(-g.fov, -view_wport/view_hport, g.viewNear, g.viewFar);
	g.squareProjMat	= matrix_build_projection_perspective_fov(-90, -1, 1, g.viewFar);
	
	g.screenOrthoProjMat = matrix_build_projection_ortho(view_wport, view_hport, 0, g.viewFar);
	g.screenOrthoViewMat = matrix_build_lookat(view_wport/2,view_hport/2,-16,view_wport/2,view_hport/2,0,0,1,0);
	
	camera_set_proj_mat(g.mainCamera, g.screenProjMat);
	view_set_camera(0, g.mainCamera);
	
	g.mainCameraObject = -1; //objCamera instance currently being used to represent camera coordinates
	
#endregion

#region CUBE MAP REFLECTIONS

	g.useCubeMapReflections = true;
	g.activeCubeMapObject = -1;

#endregion

#region SURFACE DECLARATIONS
	//Initialise global surfaces
	//Ping Pong surfaces are buffers for screen effects
	g.ping				= -1;
	g.pong				= -1;
	
	g.screen			= -1;
	g.depthMap			= -1;
	g.pointShadowMap	= -1;
#endregion

#region VERTEX FORMAT

	//Initialise standard vertex format
	vertex_format_begin();
	
		vertex_format_add_position_3d();
		vertex_format_add_normal();
		vertex_format_add_color();
		vertex_format_add_texcoord();
		
		vertex_format_add_custom(vertex_type_float3, vertex_usage_texcoord);	//Tangent
		vertex_format_add_custom(vertex_type_float3, vertex_usage_texcoord);	//Bitangent
		
	g.standardVertexFormat = vertex_format_end();
	
	
	//Initialise ray vertex format
	vertex_format_begin();
	
		vertex_format_add_position_3d();
		vertex_format_add_color();
		
	g.rayVertexFormat = vertex_format_end();
	
#endregion

#region LIGHTING

	g.ambientCol = 0; //What color are the shadows

	//Point light arrays for sending light information into a shader all at once.
	g.lightx = array_create(MAX_LIGHTS, -1);
	g.lighty = array_create(MAX_LIGHTS, -1);
	g.lightz = array_create(MAX_LIGHTS, -1);
	
	g.lightr = array_create(MAX_LIGHTS, -1);
	g.lightg = array_create(MAX_LIGHTS, -1);
	g.lightb = array_create(MAX_LIGHTS, -1);
	
	g.lightRange			= array_create(MAX_LIGHTS, -1);
	g.lightIntensity		= array_create(MAX_LIGHTS, -1);
	
	g.lightCastShadows		= array_create(MAX_LIGHTS, -1);
	g.lightSmoothShadows	= array_create(MAX_LIGHTS, -1);
	
#endregion
	
#region SHADER UNIFORMS

#region GAUSSIAN BLUR

	u_blurGauss_steps				= shader_get_uniform(shdBlurGauss, "u_steps");
	u_blurGauss_sigma				= shader_get_uniform(shdBlurGauss, "u_sigma");
	u_blurGauss_blurAxis			= shader_get_uniform(shdBlurGauss, "u_blurAxis");
	u_blurGauss_texelSize			= shader_get_uniform(shdBlurGauss, "u_texelSize");
	
#endregion

#region LUMINANCE FILTER

	u_filterLuminance_threshold		= shader_get_uniform(shdFilterLuminance, "u_threshold");
	u_filterLuminance_range			= shader_get_uniform(shdFilterLuminance, "u_range");
	
#endregion

#region POST BLOOM

	u_bloomPost_intensity			= shader_get_uniform(shdBloomPost, "u_intensity");
	u_bloomPost_darken				= shader_get_uniform(shdBloomPost, "u_darken");
	u_bloomPost_saturation			= shader_get_uniform(shdBloomPost, "u_saturation");
									
	u_bloomPost_bloomTexture		= shader_get_sampler_index(shdBloomPost, "u_bloomTexture");
	
#endregion

#region VIEW DEPTH

	g.u_viewDepth_viewFar			= shader_get_uniform(shdViewDepth, "u_viewFar");
	
#endregion

#region VIEW DISTANCE

	g.u_viewDistance_viewFar		= shader_get_uniform(shdViewDistance, "u_viewFar");
	
#endregion

#region MATERIAL
	
	//Booleans
	g.u_material_useSpecMap			= shader_get_uniform(shdMaterial, "u_useSpecMap");
	g.u_material_useNormalMap		= shader_get_uniform(shdMaterial, "u_useNormalMap");
	g.u_material_useCubeMap			= shader_get_uniform(shdMaterial, "u_useCubeMap");
	g.u_material_recieveShadows		= shader_get_uniform(shdMaterial, "u_recieveShadows");

	//External data
	g.u_material_numberOfLights		= shader_get_uniform(shdMaterial, "u_numberOfLights");
	g.u_material_camPos				= shader_get_uniform(shdMaterial, "u_camPos");
	g.u_material_ambientCol			= shader_get_uniform(shdMaterial, "u_ambientCol");
	g.u_material_viewFar			= shader_get_uniform(shdMaterial, "u_viewFar");
	
	//Texture Maps
	g.u_material_pointShadowMapTexelSize	= shader_get_uniform(shdMaterial, "u_pointShadowMapTexelSize");
	
	g.u_material_pointShadowMap		= shader_get_sampler_index(shdMaterial, "u_pointShadowMap");
	g.u_material_specMap			= shader_get_sampler_index(shdMaterial, "u_specMap");
	g.u_material_normalMap			= shader_get_sampler_index(shdMaterial, "u_normalMap");
	g.u_material_cubeMap			= shader_get_sampler_index(shdMaterial, "u_cubeMap");
	
	//Material Properties
	g.u_material_diffuseScale		= shader_get_uniform(shdMaterial, "u_diffuseScale");
	g.u_material_specScale			= shader_get_uniform(shdMaterial, "u_specScale");
	g.u_material_specPower			= shader_get_uniform(shdMaterial, "u_specPower");
	g.u_material_luminosity			= shader_get_uniform(shdMaterial, "u_luminosity");
	g.u_material_reflectScale		= shader_get_uniform(shdMaterial, "u_reflectScale");
	
	//Point Light Arrays
	g.u_material_lightx				= shader_get_uniform(shdMaterial, "u_lightx");
	g.u_material_lighty				= shader_get_uniform(shdMaterial, "u_lighty");
	g.u_material_lightz				= shader_get_uniform(shdMaterial, "u_lightz");
									
	g.u_material_lightr				= shader_get_uniform(shdMaterial, "u_lightr");
	g.u_material_lightg				= shader_get_uniform(shdMaterial, "u_lightg");
	g.u_material_lightb				= shader_get_uniform(shdMaterial, "u_lightb");
									
	g.u_material_lightRange			= shader_get_uniform(shdMaterial, "u_lightRange");
	g.u_material_lightIntensity		= shader_get_uniform(shdMaterial, "u_lightIntensity");
	
	g.u_material_lightCastShadows	= shader_get_uniform(shdMaterial, "u_lightCastShadows");
	g.u_material_lightSmoothShadows	= shader_get_uniform(shdMaterial, "u_lightSmoothShadows");

#endregion

#region WATER

	//Booleans
	g.u_water_useNormalMap		= shader_get_uniform(shdWater, "u_useNormalMap");

	//External information
	g.u_water_time				= shader_get_uniform(shdWater, "u_time");
	g.u_water_viewFar			= shader_get_uniform(shdWater, "u_viewFar");
	g.u_water_screenWidth		= shader_get_uniform(shdWater, "u_screenWidth");
	g.u_water_screenHeight		= shader_get_uniform(shdWater, "u_screenHeight");
	g.u_water_cameraPos			= shader_get_uniform(shdWater, "u_cameraPos");
	g.u_water_numberOfLights	= shader_get_uniform(shdWater, "u_numberOfLights");
	g.u_water_noiseTexelSize	= shader_get_uniform(shdWater, "u_noiseTexelSize");

	//Water attributes
	g.u_water_waterColor		= shader_get_uniform(shdWater, "u_waterColor");
	g.u_water_fogColor			= shader_get_uniform(shdWater, "u_fogColor");
	g.u_water_highlightColor	= shader_get_uniform(shdWater, "u_highlightColor");
	
	g.u_water_specScale			= shader_get_uniform(shdWater, "u_specScale");
	g.u_water_specPower			= shader_get_uniform(shdWater, "u_specPower");
	g.u_water_reflectScale		= shader_get_uniform(shdWater, "u_reflectScale");
	g.u_water_edgeDepth			= shader_get_uniform(shdWater, "u_edgeDepth");
	g.u_water_scrollx			= shader_get_uniform(shdWater, "u_scrollx");
	g.u_water_scrolly			= shader_get_uniform(shdWater, "u_scrolly");
	g.u_water_noisew			= shader_get_uniform(shdWater, "u_noisew");
	g.u_water_noiseh			= shader_get_uniform(shdWater, "u_noiseh");
	g.u_water_normalw			= shader_get_uniform(shdWater, "u_normalw");
	g.u_water_normalh			= shader_get_uniform(shdWater, "u_normalh");
	
	g.u_water_colorizeDepth			= shader_get_uniform(shdWater, "u_colorizeDepth");
	g.u_water_colorizeDepthRange	= shader_get_uniform(shdWater, "u_colorizeDepthRange");
	g.u_water_fogDepth				= shader_get_uniform(shdWater, "u_fogDepth");
	g.u_water_fogDepthRange			= shader_get_uniform(shdWater, "u_fogDepthRange");

	//Point Light Arrays
	g.u_water_lightx			= shader_get_uniform(shdWater, "u_lightx");
	g.u_water_lighty			= shader_get_uniform(shdWater, "u_lighty");
	g.u_water_lightz			= shader_get_uniform(shdWater, "u_lightz");
							
	g.u_water_lightr			= shader_get_uniform(shdWater, "u_lightr");
	g.u_water_lightg			= shader_get_uniform(shdWater, "u_lightg");
	g.u_water_lightb			= shader_get_uniform(shdWater, "u_lightb");
	
	g.u_water_lightRange		= shader_get_uniform(shdWater, "u_lightRange");
	g.u_water_lightIntensity	= shader_get_uniform(shdWater, "u_lightIntensity");

	//Texture Maps
	g.u_water_screen			= shader_get_sampler_index(shdWater, "u_screen");
	g.u_water_depthMap			= shader_get_sampler_index(shdWater, "u_depthMap");
	g.u_water_noiseMap			= shader_get_sampler_index(shdWater, "u_noiseMap");
	g.u_water_normalMap			= shader_get_sampler_index(shdWater, "u_normalMap");
	g.u_water_cubeMap			= shader_get_sampler_index(shdWater, "u_cubeMap");
	
#endregion

#endregion
}