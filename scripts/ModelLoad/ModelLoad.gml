/// @desc Load a model file into a vertex buffer
/// @arg file_path
/// @arg vertex_format

/*
	Model import script by MaddeMichael
	https://marketplace.yoyogames.com/assets/5839/export-3d-blendertogm
*/

{
	var _path	= argument0;
	var _format = argument1;
	
	//If file not found, return null
	if(!file_exists(_path)) {
		show_debug_message("Unable to find file: " + string(_path));
		return -1;
	}
	
	//Build vertex buffer from vertex data stream
	var _buff = buffer_load(_path);
	var _vbuff = vertex_create_buffer_from_buffer(_buff, _format);

	//Cleanup and return
	buffer_delete(_buff);
	return _vbuff;
}