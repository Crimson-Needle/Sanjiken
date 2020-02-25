{
	//Toggle debug
	if (keyboard_check_pressed(vk_f1)) {
		g.debug = !g.debug;
	}
	if (keyboard_check_pressed(vk_f2)) {
		g.debugPointShadowMap = !g.debugPointShadowMap;
	}
}