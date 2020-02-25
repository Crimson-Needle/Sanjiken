//Information from vertex shader
varying vec2 v_texcoord;
varying vec4 v_colour;

//Uniforms
uniform float u_intensity;
uniform float u_darken;
uniform float u_saturation;

uniform sampler2D u_bloomTexture;

void main()
{
	vec4 baseColor = texture2D(gm_BaseTexture, v_texcoord);
	vec4 bloomColor = texture2D(u_bloomTexture, v_texcoord);
	
	//Apply saturation to bloom color
	float bloomLuminance = dot(bloomColor.rgb, vec3(0.229, 0.587, 0.114));
	bloomColor.rgb = mix(vec3(bloomLuminance), bloomColor.rgb, u_saturation);
	
	//Add together base color and bloom color
	baseColor = baseColor * u_darken + bloomColor * u_intensity;
	
    gl_FragColor = v_colour * baseColor;
}
