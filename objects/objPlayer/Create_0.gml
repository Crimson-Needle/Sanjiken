{
	event_inherited();
	
	//Physics properties
	PhysInit(true, false, false, 1, 4, 2);
	BoundingBoxInit(-8, -8, -8, 8, 8, 8);
	
	//Initialise player camera
	playerCamera = CameraCreate(x,y,z);
	SetAsMainCameraObject(playerCamera);
	
	//Player control attributes
	playerMaxMoveSpeed			= 64;	//A reminder that speed is measured in units per SECOND, not units per frame.
	playerGroundAcceleration	= 256;
	playerAirAcceleration		= 64;
	playerGroundFriction		= 128;
	playerAirFriction			= 32;
	
	camSensitivity	= 0.25;
	camZoomStep		= 4;
	camLength		= 128;
	camLengthMin	= 32;
	camLengthMax	= 256;

	//Create visual for player
	var _size = 16;
	var _vbuff = BuildCube(-_size/2, -_size/2, -_size/2, _size/2, _size/2, _size/2, _size/16, _size/16);
	DrawableAdd(_vbuff, MaterialGet("Tile"), true, true, 0,0,0,0,0,0,1,1,1); 
}