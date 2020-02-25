//Vertex attributes
attribute vec3 in_Position;                 // (x,y,z)
attribute vec3 in_Normal;					// (x,y,z)
attribute vec4 in_Colour;                   // (r,g,b,a)

//Gamemaker is really dumb
//You cannot create your own names for vertex attributes, so you need to use names that already exist
attribute vec2 in_TextureCoord0;			// Texcoord		(u,v)
attribute vec3 in_TextureCoord1;			// Tangent		(x,y,z)
attribute vec3 in_TextureCoord2;			// Bitangent	(x,y,z)

//Vertex infomration that will be sent to the fragment shader
varying vec2 v_texcoord;
varying vec4 v_vertColour;
varying vec3 v_worldPos;
varying vec3 v_normal;
varying vec4 v_sunSpacePos;
varying mat3 v_TBN;

#region Main
	void main()
	{
	    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
		vec4 world_space_pos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
	
	    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
		//Pass information to the fragment shader
	    v_vertColour = in_Colour;
	    v_texcoord = in_TextureCoord0;
		v_worldPos = world_space_pos.xyz;
	
		//Transform normal, tangent and bitangent with world matrix.
		//We do this because the normal vector of a vertex does not account for 3d rotation, so we rotate it here.
		v_normal		= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
		vec3 tangent	= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_TextureCoord1, 0.0)).xyz);
		vec3 bitangent	= normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_TextureCoord2, 0.0)).xyz);
	
		//Build TBN matrix
		v_TBN = mat3(tangent, bitangent, v_normal);
	}
#endregion
