{
	//Update input states
	for (var _i = 0; _i < INPUT.count; _i ++) {
		g.input[@ _i, HOLD]		= keyboard_check(g.bind[_i]);
		g.input[@ _i, PRESS]	= keyboard_check_pressed(g.bind[_i]);
		g.input[@ _i, RELEASE]	= keyboard_check_released(g.bind[_i]);
	}
}