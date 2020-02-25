{
	var	_layer = layer_get_id("Background");
	var _background = layer_background_get_id(_layer);
	var _col = layer_background_get_blend(_background);
	
	draw_clear_alpha(_col, 1);
}