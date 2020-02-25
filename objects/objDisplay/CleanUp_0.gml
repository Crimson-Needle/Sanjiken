{
	//Cleanup surfaces
	if (surface_exists(g.ping)) surface_free(g.ping);
	if (surface_exists(g.pong)) surface_free(g.pong);
	if (surface_exists(g.screen)) surface_free(g.screen);
	if (surface_exists(g.depthMap)) surface_free(g.depthMap);
	if (surface_exists(g.pointShadowMap)) surface_free(g.pointShadowMap);
	
	//Cleanup vertex formats
	vertex_format_delete(g.standardVertexFormat);
	
	//Cleanup data structures
	
	//Cleanup cameras
	camera_destroy(g.mainCamera);
	camera_destroy(g.utilityCamera);
}