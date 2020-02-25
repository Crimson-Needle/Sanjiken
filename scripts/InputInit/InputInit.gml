{
	//Initialise input arrays
	g.bind	= array_create(INPUT.count);
	g.input	= array_create(INPUT.count);
	
	//Initialise default keybindings
	g.bind[@ INPUT.LEFT]		= vk_left;
	g.bind[@ INPUT.RIGHT]		= vk_right;
	g.bind[@ INPUT.UP]			= vk_up;
	g.bind[@ INPUT.DOWN]		= vk_down;
	
	g.bind[@ INPUT.ALT_LEFT]	= ord("A");
	g.bind[@ INPUT.ALT_RIGHT]	= ord("D");
	g.bind[@ INPUT.ALT_UP]		= ord("W");
	g.bind[@ INPUT.ALT_DOWN]	= ord("S");
	
	g.bind[@ INPUT.JUMP]		= vk_space;
	g.bind[@ INPUT.CROUCH]		= vk_control;
	
	g.bind[@ INPUT.RESTART]		= ord("R");
	
	//Initialise input states
	for (var _i = 0; _i < INPUT.count; _i ++) {
		g.input[@ _i, HOLD]		= false;
		g.input[@ _i, PRESS]	= false;
		g.input[@ _i, RELEASE]	= false;
	}
}