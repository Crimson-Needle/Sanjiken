{
	//Parent
	event_inherited();
	
	//Don't draw self. Drawing is controlled by objDisplay
	visible = false;
	
	//Water
	colorizeDepth = -16;
	colorizeDepthRange = 48;
	fogDepth = 32;
	fogDepthRange = 128;
	
	//Drawable
	vbuff = -1;
}