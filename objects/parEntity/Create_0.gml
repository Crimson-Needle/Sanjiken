{
	zstart = z;

	//Initialise default physics properties.
	PhysInit(false, false, true, 1, 0, 0);
	
	//Initialise default bounding box for collisions.
	BoundingBoxInit(-8, -8, -8, 8, 8, 8);
}