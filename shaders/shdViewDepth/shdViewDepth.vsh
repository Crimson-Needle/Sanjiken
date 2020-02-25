//Draw every pixel on a scale between black and white based on the pixel's view-depth.
//Pixels with a higher view depth will appear lighter and pixels with a lower view-depth will appear darker.
//The view-depth is the pixel's z-coordinate after its coordinates have been converted to view-space.

attribute vec3 in_Position;                 // (x,y,z)
attribute vec3 in_Normal;					// (x,y,z)
attribute vec4 in_Colour;                   // (r,g,b,a)
attribute vec2 in_TextureCoord;             // (u,v)

varying float v_depth;

uniform float u_viewFar;

void main()
{
	//Calculate coordinates for different spaces
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	vec4 view_space_pos = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
	
	//Finalise screen space coordinates
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * view_space_pos;
    
    //Pass depth value to fragment shader
	v_depth = view_space_pos.z;
}
