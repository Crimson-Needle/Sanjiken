///@desc Returns a vertex buffer containing a 3d quad with the specified coordinates
///@arg x1
///@arg y1
///@arg z1
///@arg x2
///@arg y2
///@arg z2
///@arg x3
///@arg y3
///@arg z3
///@arg x4
///@arg y4
///@arg z4
///@arg h_repeat
///@arg v_repeat

///@arg u
///@arg v
///@arg w
///@arg h
{
	var _x1	= argument[0];
	var _y1	= argument[1];
	var _z1	= argument[2];
	
	var _x2	= argument[3];
	var _y2	= argument[4];
	var _z2	= argument[5];
	
	var _x3	= argument[6];
	var _y3	= argument[7];
	var _z3	= argument[8];
	
	var _x4	= argument[9];
	var _y4	= argument[10];
	var _z4	= argument[11];
	
	var _hrepeat	= argument[12];
	var _vrepeat	= argument[13];
	
#region Texture Information

	var _u1 = 0;		   //x coordinate of texture on texture page
	var _v1 = 0;		   //y coordinate of texture on texture pahe
	var _u2 = _u1 + _hrepeat; //width of texture on texture page
	var _v2 = _v1 + _vrepeat; //height of texture on texture page

	var _color = c_white;
	var _alpha = 1;
#endregion


#region Normal Information
	var _n1 = Cross3d(
		_x2-_x1, _y2-_y1, _z2-_z1,
		_x3-_x1, _y3-_y1, _z3-_z1);
	var _n2 = Cross3d(
		_x4-_x3, _y4-_y3, _z4-_z3,
		_x4-_x2, _y4-_y2, _z4-_z2);
		
	//Normalise the cross product
	_n1 = Normalize3d(_n1[X], _n1[Y], _n1[Z]);
	_n2 = Normalize3d(_n2[X], _n2[Y], _n2[Z]);
#endregion


#region //Build Vertex Buffer
	var _buf = vertex_create_buffer();
	vertex_begin(_buf, g.standardVertexFormat);

		//First Triangle
		Triangle(
			_buf,
			_x1, _y1, _z1,
			_x2, _y2, _z2,
			_x3, _y3, _z3,
			_u1, _v1,
			_u2, _v1,
			_u1, _v2
		);

		//Second Triangle
		Triangle(
			_buf,
			_x4, _y4, _z4,
			_x3, _y3, _z3,
			_x2, _y2, _z2,
			_u2, _v2,
			_u1, _v2,
			_u2, _v1
		);

	vertex_end(_buf);
#endregion

	return _buf;
}