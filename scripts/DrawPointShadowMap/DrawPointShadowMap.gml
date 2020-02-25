///@desc draw point shadow map with cell information
{
	/*
		This script was made purely for debugging purposes.
		It is not relevant to the rendering pipeline.
	*/
	
	//Debug surfaces and framebuffers
	if (surface_exists(g.pointShadowMap)) {
		var _w = surface_get_width(g.pointShadowMap);
		var _h = surface_get_height(g.pointShadowMap);
		var _ratio = min(1, min(view_wport/_w, view_hport/_h));
		
		draw_surface_stretched(g.pointShadowMap, 0, 0, _w*_ratio, _h*_ratio);
		
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_font(fontDisplay);
		
		//Point shadow map grid cell differentiation
		var _currentCell = 0;
		var _gridCells = surface_get_width(g.pointShadowMap)/(g.pointShadowMapSize*4);
		for (var _y = 0; _y < _gridCells; _y++) {
			
			var _liney = (g.pointShadowMapSize*2) * _y;
			draw_line(0, _liney*_ratio, _w*_ratio, _liney*_ratio);
			
			for (var _x = 0; _x < _gridCells; _x++) {
				
				var _linex = (g.pointShadowMapSize*4) * _x;
				draw_line(_linex*_ratio, 0, _linex*_ratio,_h*_ratio);
			
				draw_text(_linex*_ratio, _liney*_ratio, string(_currentCell));
				_currentCell++;
			}
		}
		
		//Border
		
		draw_rectangle(0,0,_w*_ratio-1,_h*_ratio-1,true);
	}
}