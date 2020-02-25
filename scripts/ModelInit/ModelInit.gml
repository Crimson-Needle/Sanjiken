{
	g.modelMap = ds_map_create();

	//Basic Shapes
	ModelAdd("Cube",
		ModelLoad("models/shapes/cube.dat", g.standardVertexFormat)
	);
	ModelAdd("Sphere",
		ModelLoad("models/shapes/uv_sphere.dat", g.standardVertexFormat)
	);
	ModelAdd("Cyllinder",
		ModelLoad("models/shapes/cyllinder.dat", g.standardVertexFormat)
	);
}