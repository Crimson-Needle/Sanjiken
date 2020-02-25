{
	/*
		Compile all of the data from all of the point lights into single arrays.
		Once all of the light information is in one place, we can send it to a shader.
	*/
	
	//Pack all lighting data into arrays
	for (var _i = 0; _i < min(MAX_LIGHTS, instance_number(objPointLight)); _i ++) {
		
		//Get light instance
		var _o = instance_find(objPointLight, _i);
		
		if ((_o.static && g.firstFrame) ||  !_o.static) {
			//Pack light isntance properties into global light arrays
			g.lightx[_i] = _o.x;
			g.lighty[_i] = _o.y;
			g.lightz[_i] = _o.z;
		
			g.lightr[_i] = color_get_red(_o.color)/255;
			g.lightg[_i] = color_get_green(_o.color)/255;
			g.lightb[_i] = color_get_blue(_o.color)/255;
		
			g.lightRange[_i]		= _o.range;
			g.lightIntensity[_i]	= _o.intensity;
			
			g.lightCastShadows[_i]		= _o.castShadows;
			g.lightSmoothShadows[_i]	= _o.smoothShadows;
		}
		
	}
	
	
	//Determine which instance of objCubeMap should be used for reflections. The one closest to the camera will be used.
	var _cubeMapObject = -1;
	var _shortest = -1;
	
	for (var _i = 0; _i < instance_number(objCubeMap); _i++) {
		var _o = instance_find(objCubeMap, _i);
		var _length = Length3d(_o.x - CameraGetX(), _o.y - CameraGetY(), _o.z - CameraGetZ())
		
		if (_shortest == -1 || _length < _shortest) {
			_shortest = _length;
			_cubeMapObject = _o;
		}
	}
	
	g.activeCubeMapObject = _cubeMapObject;
}