///@arg x1
///@arg y1
///@arg z1
///@arg x2
///@arg y2
///@arg z2
///@arg h_repeat
///@arg v_repeat
{
	var _x1	= argument[0];
	var _y1	= argument[1];
	var _z1	= argument[2];
	
	var _x2	= argument[3];
	var _y2	= argument[4];
	var _z2	= argument[5];
	
	var _hrepeat	= argument[6];
	var _vrepeat	= argument[7];
	
	//Begin constructing cube vertex buffer
	var _buf = vertex_create_buffer();
	
#region Top
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x1, _y1, _z2,
			_x2, _y1, _z2,
			_x1, _y2, _z2,
			_x2, _y2, _z2,
			_hrepeat, _vrepeat),
			true);
#endregion

#region Bottom
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x1, _y2, _z1,
			_x2, _y2, _z1,
			_x1, _y1, _z1,
			_x2, _y1, _z1,
			_hrepeat, _vrepeat),
			true);
#endregion
		
#region Front
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x2, _y2, _z1,
			_x1, _y2, _z1,
			_x2, _y2, _z2,
			_x1, _y2, _z2,
			_hrepeat, _vrepeat),
			true);
#endregion

#region Back
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x1, _y1, _z1,
			_x2, _y1, _z1,
			_x1, _y1, _z2,
			_x2, _y1, _z2,
			_hrepeat, _vrepeat),
			true);
#endregion

#region Left
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x1, _y2, _z1,
			_x1, _y1, _z1,
			_x1, _y2, _z2,
			_x1, _y1, _z2,
			_hrepeat, _vrepeat),
			true);
#endregion

#region Right
	_buf = VertexBufferConcat( _buf,
		BuildQuad(
			_x2, _y1, _z1,
			_x2, _y2, _z1,
			_x2, _y1, _z2,
			_x2, _y2, _z2,
			_hrepeat, _vrepeat),
			true);
#endregion

	return _buf;
}