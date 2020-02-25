attribute vec3 in_Position;                 // (x,y,z)
attribute vec3 in_Normal;					// (x,y,z)
attribute vec4 in_Colour;                   // (r,g,b,a)
attribute vec2 in_TextureCoord;             // (u,v)

uniform float u_viewFar;

varying vec3 v_viewPos;

void main()
{
	//Calculate coordinates for different spaces
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	vec4 view_space_pos = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
	
	//Finalise screen space coordinates
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * view_space_pos;
	
	//Pass view position to fragment shader
	v_viewPos = view_space_pos.xyz;
}
