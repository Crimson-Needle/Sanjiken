{
	//Parent
	event_inherited();
	
	//Dimensions
	w = sprite_width;
	h = sprite_height;
	
	//Physics properties
	PhysInit(false, false, true, 0, 0, 0);
	BoundingBoxInit(0, 0, 0, w, h, d);
	
	//Water plane model
	vbuff = BuildFloor(0, 0, z+d, w, h, z+d, 1, 1);
}