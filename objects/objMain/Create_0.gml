/// @description Main
{
	//Framerate and timesteps
	g.maxfps = 240;
	room_speed = g.maxfps;
	
	fixedTimeStep = 60; //How many times per second does a fixed update occur regardless of actual framerate.
	fixedStepOffset = 0;
	
	seconds = 0;
	realfps = 0;
	
	//debug
	g.debug = true;
	g.debugPointShadowMap = false;
	
	//Time
	g.time = 0;
	g.sinTime = 0;
	
	//Create instances
	g.display = instance_create_layer(0, 0, "Instances", objDisplay);
	g.inputManager = instance_create_layer(0, 0, "Instances", objInputManager);
	g.cameraController = instance_create_layer(0, 0, "Instances", objCameraController);
	
	//Initialise physics
	g.physTerminal = 1024;
	g.physGravity  = 512;
	
	//Initialise data and assets
	ModelInit();
	MaterialInit();
}