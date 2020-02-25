///@desc Combine 2 different vertex buffers into one single vertex buffer.
///@arg buffer1
///@arg buffer1
///@arg destroy_old_buffers
{
	var _vbuf1 = argument[0];
	var _vbuf2 = argument[1];
	var _destroy = argument[2]
	
	//If vertex buffer 1 is empty, create a new empty buffer
	var _buf 
	if (vertex_get_number(_vbuf1) == 0)
		_buf = buffer_create(0, buffer_grow, 1);
	else
		_buf = buffer_create_from_vertex_buffer(_vbuf1, buffer_grow, 1);
	
	//Combine vertex buffers into a standard buffer, then convert standard buffer into a new vertex buffer
	buffer_copy_from_vertex_buffer(_vbuf2, 0, vertex_get_number(_vbuf2), _buf, buffer_get_size(_buf));
	var _final = vertex_create_buffer_from_buffer(_buf, g.standardVertexFormat);
	
	//Cleanup
	buffer_delete(_buf);
	
	if (_destroy) {
		vertex_delete_buffer(_vbuf1);
		vertex_delete_buffer(_vbuf2)
	}
	
	//Return new vertex buffer
	return _final;
}