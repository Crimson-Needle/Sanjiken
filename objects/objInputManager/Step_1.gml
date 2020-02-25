{
	//Update input steps
	InputUpdate();
	
	//Toggle cursor lock
	if (keyboard_check_pressed(vk_escape)) {
		g.cursorLock = !g.cursorLock;
	}
	
	//Get mouse speed and direction
	g.mouse_xspd = window_mouse_get_x() - g.mouse_xprev;
	g.mouse_yspd = window_mouse_get_y() - g.mouse_yprev;
	
	g.mouse_direction = Yaw(g.mouse_xprev, g.mouse_yprev,  window_mouse_get_x(),  window_mouse_get_y());
	
	//Lock cursor
	if (g.cursorLock) {
		window_set_cursor(cr_none);
		
		//Lock mouse to screen center
		window_mouse_set(view_wport/2, view_hport/2);
		g.mouse_xprev = view_wport/2;
		g.mouse_yprev = view_hport/2;
	}
	else {
		window_set_cursor(cr_default);
		
		//Update previous mouse position
		g.mouse_xprev = window_mouse_get_x();
		g.mouse_yprev = window_mouse_get_y();
	}
}