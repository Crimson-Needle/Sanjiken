/*
	All post processing shaders were made with assistance from Gaming Reverend's youtube tutorials on shaders.

	https://forum.yoyogames.com/index.php?members/the-reverend.5034/
	https://www.youtube.com/channel/UC7fkptPD1FHQyDc9Fnm9S_A
*/

attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_texcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_texcoord = in_TextureCoord;
}
