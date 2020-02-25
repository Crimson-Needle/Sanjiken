{
	if (g.debugPointShadowMap) {
		DrawPointShadowMap();
	} 
	else if (g.debug) {
		draw_set_color(c_white);
		draw_set_font(fontDisplay);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		//Draw fps
		draw_text(0,0,string(fps));
		draw_text(0,24,string(realfps));
		
		//Draw instructions
		draw_text(0,64,
			"f1: Toggle display\n" +
			"f2: Toggle show point shadow map\n" +
			"\n" +
			"Escape: Toggle cursor lock\n" +
			"Mouse: Control camera\n" +
			"WASD: Move\n" +
			"Space: Jump\n" +
			"R: Restart"
		);
	}
	
}