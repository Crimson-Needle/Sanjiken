//Information from vertex shader
varying vec2 v_texcoord;

//Uniforms
uniform float u_threshold;
uniform float u_range;

void main()
{
	vec4 sample = texture2D( gm_BaseTexture, v_texcoord);
	
	float luminance = dot(sample.rgb, vec3(0.229, 0.587, 0.114));
	float weight	= smoothstep(u_threshold, u_threshold + u_range, luminance);
	
    gl_FragColor = vec4(sample.rgb * weight, sample.a);
}
