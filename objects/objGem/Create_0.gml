{
	//Parent
	event_inherited();
	
	//Physics properties
	PhysInit(true, false, true, 0, 0, 0);
	BoundingBoxInit(-8, -8, -8, 8, 8, 8);
	
	//Setup visuals
	var _size	= 0.5;
	mainBody	= DrawableAdd(ModelGet("Cube"), MaterialGet("Gem"), true, true, 0,0,0, 45,45,0, _size,_size,_size);
	smallBody1	= DrawableAdd(ModelGet("Cube"), MaterialGet("Gem"), true, true, 0,0,0, 45,45,0, _size*0.25,_size*0.25,_size*0.25);
	smallBody2	= DrawableAdd(ModelGet("Cube"), MaterialGet("Gem"), true, true, 0,0,0, 45,45,0, _size*0.25,_size*0.25,_size*0.25);
	
	//Animation properties
	rotateSpeed		= 180;
	smallBodyYaw	= 0;
	smallBodyPitch	= 0;
	smallBodyLength = _size * 24;
}
	
	