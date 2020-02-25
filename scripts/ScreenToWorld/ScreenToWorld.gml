///@arg x
///@arg y
///@arg depth

/*
	ScreenToWorld and WorldToScreen scripts by FlyingSaucerInvasion.

	https://forum.yoyogames.com/index.php?members/flyingsaucerinvasion.237/
	https://forum.yoyogames.com/index.php?threads/conversion-from-3d-to-2d-and-vice-versa-slightly-wrong.42162/
*/

{
	var _screenx	= argument0;
	var _screeny	= argument1;
	var _depth		= argument2; //The distance from the camera that the return point will be located.
	
	var _width = view_wport;
	var _height = view_hport;
	var _aspect = _width/_height;
	
	var _v = camera_get_view_mat(g.mainCamera);
	var _camx = CameraGetX();
	var _camy = CameraGetY();
	var _camz = CameraGetZ();
	
	var _fov = g.fov;
	var _t = dtan( _fov / 2 );
	
    _screenx = _aspect * _t * ( 2 * _screenx / _width - 1 ) * _depth;
    _screeny = _t * ( 1 - 2 * _screeny / _height ) * _depth;
	
    var _x = _camx + _screenx * _v[0] + _screeny * _v[1] + _depth * _v[2];
    var _y = _camy + _screenx * _v[4] + _screeny * _v[5] + _depth * _v[6];
    var _z = _camz + _screenx * _v[8] + _screeny * _v[9] + _depth * _v[10];
	
	var _vec;
	_vec[X] = _x;
	_vec[Y] = _y;
	_vec[Z] = _z;
	
	return _vec;
}