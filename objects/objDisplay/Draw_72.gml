///@desc Draw Scene
{
	/*
		This is the main drawing pipeline which sets up framebuffers and draws the scene.
		All drawing occurs in this event rather than each drawable's draw event.
		This is because in order for all of the visual effects to work correctly, certain elements MUST be drawn before others.
		Drawing order is very important, so I control the order here.
	*/

#region Setup Frame Buffers

	//Surfaces are very volatile and will delete themselves if the window loses focus.
	//Thus, we recreate them as needed.
	
	if (!surface_exists(g.ping)) 
		g.ping = surface_create(view_wport, view_hport);
		
	if (!surface_exists(g.pong)) 
		g.pong = surface_create(view_wport, view_hport);
		
	if (!surface_exists(g.screen)) 
		g.screen = surface_create(view_wport, view_hport);
		
	if (!surface_exists(g.depthMap)) 
		g.depthMap = surface_create(view_wport, view_hport);
		
	var _gridSize = ceil(sqrt(MAX_LIGHTS)); //The point shadowmap is organised into a grid of cells. Each cell contains the shadowmaps of 2 lights. Press f2 to see this in action while in-game.
	if (!surface_exists(g.pointShadowMap))
		g.pointShadowMap = surface_create(_gridSize*g.pointShadowMapSize*4, _gridSize*g.pointShadowMapSize*2); 

#endregion
	
#region Compile Point Light Data

	//Clear point shadow map
	surface_set_target(g.pointShadowMap);
		draw_clear_alpha(0,1);
	surface_reset_target();
	
	
	//Build and compile point shadow maps
	for (var _i = 0; _i < min(MAX_LIGHTS, instance_number(objPointLight)); _i ++) {
		
		var _o = instance_find(objPointLight, _i);
		
		//If a point light is not static and can cast shadows, then its shadowmap must be rebuilt every frame.
		//If a point light's shadowmap surface has deleted itself, recreate the surface then rebuild the map.
		var _rebuild = !_o.static && _o.castShadows;
		
		if (!surface_exists(_o.cubeMap)) {
			_o.cubeMap = surface_create(g.pointShadowMapSize*4, g.pointShadowMapSize*2);
			_rebuild =  _o.castShadows;
		}
			
		if (_rebuild) {
			BuildCubeMap(_o.cubeMap, _o.x, _o.y, _o.z, g.pointShadowMapSize, DRAW_VIEW_DISTANCE, false, _o.static, false);
		}
		
		
		//Pack all of the point lights' shadow maps onto a single surface so that they can easily be sent to a shader.
		surface_set_target(g.pointShadowMap);
		
			CameraPrepare2d(g.utilityCamera, surface_get_width(g.pointShadowMap), surface_get_height(g.pointShadowMap));
			camera_apply(g.utilityCamera);
		
			var _xcell = floor(_i) mod _gridSize;
			var _ycell = floor(floor(_i) / _gridSize);
			
			draw_surface(_o.cubeMap, _xcell*g.pointShadowMapSize*4, _ycell*g.pointShadowMapSize*2);
	
		surface_reset_target();
	}
	
#endregion

#region Build Cube Maps

	for (var _i = 0; _i < instance_number(objCubeMap); _i ++) {
		var _o = instance_find(objCubeMap, _i);
			
		if (!surface_exists(_o.cubeMap)) {
			_o.cubeMap = surface_create(g.cubeMapSize * 4, g.cubeMapSize * 2);
			
			ReflectionsDisable();
			BuildCubeMap(_o.cubeMap, _o.x, _o.y, _o.z, g.cubeMapSize, DRAW_MATERIAL, true, true, false);
			ReflectionsEnable();
		}
	}
	
#endregion
	
#region Build Scene Maps

	//Scene depth map
	ProjectOntoSurface(g.depthMap, DRAW_VIEW_DEPTH, g.mainCamera, false, false, false);
	
#endregion

#region Draw Scene
	
		//Draw entire scene
		with (parDrawable)
			DrawThis(DRAW_MATERIAL);
		
		//Prepare a screengrab so that we can pass it to shaders as a texture
		if (surface_exists(application_surface))
			surface_copy(g.screen, 0, 0, application_surface);
			
		//Draw all water
		with (parWater)
			event_perform(ev_draw, 0);
		
		//Draw additional effects
		//...

#endregion
}