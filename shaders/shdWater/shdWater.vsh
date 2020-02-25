//Vertex attributes
attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;

//Gamemaker is really dumb
//You cannot create your own names for vertex attributes, so you need to use names that already exist
attribute vec2 in_TextureCoord0;			// Texcoord		(u,v)
attribute vec3 in_TextureCoord1;			// Tangent		(x,y,z)
attribute vec3 in_TextureCoord2;			// Bitangent	(x,y,z)

//Vertex infomration which will be sent to the fragment shader
varying vec2 v_texcoord;
varying vec3 v_worldPos;
varying vec3 v_normal;
varying float v_depth;
varying mat3 v_TBN;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	vec4 world_space_pos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
	vec4 view_space_pos = gm_Matrices[MATRIX_VIEW] * world_space_pos;
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * view_space_pos;
	
	//Transform normal, tangent and bitangent with world matrix
	vec3 normal		= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
	vec3 tangent	= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_TextureCoord1, 0.0)).xyz);
	vec3 bitangent	= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_TextureCoord2, 0.0)).xyz);
	
	//Build TBN matrix
	v_TBN = mat3(tangent, bitangent, normal);
	
	//Pass infro to fragment shader
	v_worldPos = world_space_pos.xyz;
	v_depth = view_space_pos.z;
    v_texcoord = in_TextureCoord0;
	v_normal = normal;
}
