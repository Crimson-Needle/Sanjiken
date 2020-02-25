//Information from vertex shader
varying vec2 v_texcoord;
varying vec4 v_colour;

//Uniforms
uniform int u_steps;
uniform float u_sigma;
uniform vec2 u_blurAxis;
uniform vec2 u_texelSize;

float weight(float pos) {
	return exp(-(pos * pos) / (2.0 * u_sigma * u_sigma));
}

void main()
{
	highp vec4 finalColor = vec4(0.0);
	
	float kernel = float(u_steps * 2 + 1); 
	float totalWeight = 0.0;
	
	for (int i = -u_steps; i <= u_steps; i++) {
		float offset = float(i);
		vec2 uv = v_texcoord + u_blurAxis * u_texelSize * offset;
		
		//Don't sample the other side of the screen
		if (uv.x > 1.0 || uv.x < 0.0 || uv.y > 1.0 || uv.y < 0.0)
			continue;
		
		float sampleWeight = weight(offset/kernel);
		totalWeight += sampleWeight;
		
		finalColor += texture2D(gm_BaseTexture, uv) * sampleWeight;
	}
	
    gl_FragColor = finalColor/totalWeight;
}
