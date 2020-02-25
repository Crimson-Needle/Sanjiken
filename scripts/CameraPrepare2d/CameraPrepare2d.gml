///@arg camera
///@arg width
///@arg height
{
	var _cam	= argument0;
	var _w		= argument1;
	var _h		= argument2;
	
	//Prepare matrices
	var _view = matrix_build_lookat(_w/2, _h/2, -16, _w/2, _h/2, 0, 0, 1, 0);
	var _proj = matrix_build_projection_ortho(_w, _h, 0, g.viewFar);
	
	camera_set_view_mat(_cam, _view);
	camera_set_proj_mat(_cam, _proj);
}