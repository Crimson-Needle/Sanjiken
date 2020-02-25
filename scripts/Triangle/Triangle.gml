//@desc Build a triangle in a vertex buffer. All extra information like surface normals are calculated.

///@arg vbuff

///@arg x1
///@arg y1
///@arg z1

///@arg x2
///@arg y2
///@arg z2

///@arg x3
///@arg y3
///@arg z3

///@arg u1
///@arg v1
///@arg u2
///@arg v2
///@arg u3
///@arg v3

{
	var _vbuff = argument[0];
	
	var _x1	= argument[1];
	var _y1	= argument[2];
	var _z1	= argument[3];
	
	var _x2	= argument[4];
	var _y2	= argument[5];
	var _z2	= argument[6];
	
	var _x3	= argument[7];
	var _y3	= argument[8];
	var _z3	= argument[9];
	
	var _u1	= argument[10];
	var _v1	= argument[11];
	var _u2	= argument[12];
	var _v2	= argument[13];
	var _u3	= argument[14];
	var _v3	= argument[15];
	
	var _col = c_white;
	var _alpha = 1;
	
#region Triangle Normal

	//The triangle normal is a directional vector.
	//It represents the direction that the triangle's surface is facing.
	//It is used by shaders to calculate how this triangle reflects light.

	//Use cross product to find perpendicular normal vector
	var _n = Cross3d(
		_x2-_x1, _y2-_y1, _z2-_z1,
		_x3-_x1, _y3-_y1, _z3-_z1);
		
	//Make sure the normal vector is a unit vector
	_n = Normalize3d(_n[X], _n[Y], _n[Z]);
	
#endregion
	
#region Tangent and Bitangent Vectors

	//The tangent and bitangent are directional vectors.
	//They represent 2 perpendicular axis that describe the triangle's local space.
	//They are used to build the Tangent-Bitangent-Normal matrix (TBN) in shaders.
	//Shaders use the TBN to transform local x,y,z coordinates into local triangle space.
	//This is very useful for transforming directions into directions that are relative to the triangle's surface.

	//UV delta
	var _du1 = _u2 - _u1;
	var _dv1 = _v2 - _v1;
	var _du2 = _u3 - _u2;
	var _dv2 = _v3 - _v2;
	
	//Edge delta
	var _e1x = _x2 - _x1;
	var _e1y = _y2 - _y1;
	var _e1z = _z2 - _z1;
	var _e2x = _x3 - _x2;
	var _e2y = _y3 - _y2;
	var _e2z = _z3 - _z2;
	
	//Matrix inversion
	var _f = 1.0 / (_du1 * _dv2 - _du2 * _dv1);
	
	//Tangent Vector
	var _tx = _f * (_dv2 * _e1x - _dv1 * _e2x);
	var _ty = _f * (_dv2 * _e1y - _dv1 * _e2y);
	var _tz = _f * (_dv2 * _e1z - _dv1 * _e2z);
	var _t;
	_t = Normalize3d(_tx, _ty, _tz);
	
	//Bitangent Vector
	var _bx = _f * (_du2 * _e1x + _du1 * _e2x);
	var _by = _f * (_du2 * _e1y + _du1 * _e2y);
	var _bz = _f * (_du2 * _e1z + _du1 * _e2z);
	var _b; 
	_b = Normalize3d(_bx, _by, _bz);
	
#endregion

#region Build Triangle

	//Vertex 1
	vertex_position_3d(_vbuff, _x1, _y1, _z1);
	vertex_normal(_vbuff, _n[X], _n[Y], _n[Z]);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u1, _v1);
	
	vertex_float3(_vbuff, _t[X], _t[Y], _t[Z]);
	vertex_float3(_vbuff, _b[X], _b[Y], _b[Z]);
	
	//Vertex 2
	vertex_position_3d(_vbuff, _x2, _y2, _z2);
	vertex_normal(_vbuff, _n[X], _n[Y], _n[Z]);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u2, _v2);
	
	vertex_float3(_vbuff, _t[X], _t[Y], _t[Z]);
	vertex_float3(_vbuff, _b[X], _b[Y], _b[Z]);
	
	//Vertex 3
	vertex_position_3d(_vbuff, _x3, _y3, _z3);
	vertex_normal(_vbuff, _n[X], _n[Y], _n[Z]);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u3, _v3);
	
	vertex_float3(_vbuff, _t[X], _t[Y], _t[Z]);
	vertex_float3(_vbuff, _b[X], _b[Y], _b[Z]);

#endregion
}