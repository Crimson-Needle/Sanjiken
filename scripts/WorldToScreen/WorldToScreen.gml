///@arg x
///@arg y
///@arg z

/*
	ScreenToWorld and WorldToScreen scripts by FlyingSaucerInvasion.

	https://forum.yoyogames.com/index.php?members/flyingsaucerinvasion.237/
	https://forum.yoyogames.com/index.php?threads/conversion-from-3d-to-2d-and-vice-versa-slightly-wrong.42162/
*/

{
	var _x = argument0;
	var _y = argument1;
	var _z = argument2;
	
	//Get view and projection matrix
	var _view = camera_get_view_mat(g.mainCamera);
	var _proj = camera_get_proj_mat(g.mainCamera);
	
	var _pv = matrix_multiply(_view, _proj);
	
	//Calculate perspective divide
	var _w =  _x * _pv[3] + _y * _pv[7] + _z * _pv[11] + _pv[15];
	
	//Calculate screen coordinates
    if (_w > 0) {
        var _screenx = (_x * _pv[0] + _y * _pv[4] + _z * _pv[8]  + _pv[12]) / _w;
        var _screeny = (_x * _pv[1] + _y * _pv[5] + _z * _pv[9]  + _pv[13]) / _w;
        _screenx = (view_wport/2) + _screenx * (view_wport/2);
        _screeny = (view_hport/2) - _screeny * (view_hport/2);
		
		//Pack coordinates into vector
		var _vec;
		_vec[X] = _screenx;
		_vec[Y] = _screeny;
		
		return _vec;
    }
	
	return -1;
}	