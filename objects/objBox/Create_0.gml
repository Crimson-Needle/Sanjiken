{
	//Parent
	event_inherited();
	
	//Dimensions
	w = sprite_width;
	h = sprite_height;
	
	//Physics properties
	PhysInit(true, true, true, 0, 0, 0);
	BoundingBoxInit(0, 0, 0, w, h, d);
	
	//Drawable properties
	static = true;
	
	//Build box visuals
	var _floorMat	= MaterialGet("Tile");//MaterialGet("Tile");
	var _wallMat	= MaterialGet("Brick");//MaterialGet("Brick");
	var _floorw		= 16;
	var _floorh		= 16;
	var _wallw		= 16;
	var _wallh		= 16;
	
	var _cast = true;
	var _recieve = true;
	
	DrawableAdd(BuildWall(0, h, 0, 0, 0, d, h/_wallw, d/_wallh), _wallMat, _cast, _recieve,
		0,0,0,0,0,0,1,1,1); //LEFT
		
	DrawableAdd(BuildWall(w, 0, 0, w, h, d, h/_wallw, d/_wallh), _wallMat, _cast, _recieve,
		0,0,0,0,0,0,1,1,1); //RIGHT
	
	DrawableAdd(BuildWall(0, 0, 0, w, 0, d, w/_wallw, d/_wallh), _wallMat, _cast, _recieve,
		0,0,0,0,0,0,1,1,1); //FRONT
		
	DrawableAdd(BuildWall(w, h, 0, 0, h, d, w/_wallw, d/_wallh), _wallMat, _cast, _recieve,
		0,0,0,0,0,0,1,1,1);	//BACK
	
	DrawableAdd(BuildFloor(w, 0, 0, 0, h, 0, -w/_floorw, h/_floorh), _floorMat, _cast, _recieve, 
		0,0,0,0,0,0,1,1,1); //BOTTOM
		
	DrawableAdd(BuildFloor(0, 0, d, w, h, d, w/_floorw, h/_floorh), _floorMat, _cast, _recieve,
		0,0,0,0,0,0,1,1,1); //TOP
	
	//idk if these vertex buffers will be deleted after the drawable list is destroyed.
	//This may create a huge memory leak. As all drawables from one scene will still be in memory when the scene changes.
}