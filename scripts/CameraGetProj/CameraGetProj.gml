//For whatever reason, gamemaker flips projection matrices upside down when they are applied to cameras.
//Thus, getting a projection matrix from a camera via camera_get_proj_mat() will always return a flipped projection.
//This script gets a projection matrix from a camera, then un-flips it.

///@arg camera
{
	var _cam = argument[0];
	
	//Get projection matrix, then invert the projection.
	var _mat = camera_get_proj_mat(_cam);
	_mat[5] *= -1;
	
	return _mat;
}