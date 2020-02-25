varying float v_depth;

#region Data To Color
	vec3 dataToColor(float data) 
	{
		/*
			Shaders store rgb colors in 12 bytes. GameMaker stores rgb colors in 3 bytes.
			After the shader returns control to GameMaker and the colors are drawn to a surface, the 12 bytes of data gets crunched down into 3 bytes.
			Because of this, most of the information stored within the color is lost. This script attempts to remedy this issue by spreading the
			data stored in a float over the rgb components of a color.
		
			the final value will be r+g+b. 
			r is 0 - 255, g is 0 - 65536, b is the decimal point.
			Very hacky, but it works for what it needs to do.
		*/
	
		float whole = floor(data);
		float fraction = data - whole;

		float r = mod(whole, 256.0);
		float g = mod(floor(whole/256.0), 256.0);
		float b = fraction;
	
		return vec3(r/255.0, g/255.0, b);
	}
#endregion

#region Main
	void main()
	{
		gl_FragColor = vec4(dataToColor(v_depth), 1.0);
	}
	#endregion