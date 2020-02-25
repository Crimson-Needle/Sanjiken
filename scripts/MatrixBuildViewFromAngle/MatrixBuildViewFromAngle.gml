///@desc Builds a view matrix with the specified camera transformation.
///@arg x
///@arg y
///@arg z
///@arg yaw
///@arg pitch
{
	var _x		= argument0;
	var _y		= argument1;
	var _z		= argument2;
	var _yaw	= argument3;
	var _pitch	= argument4;
	
	
	//Calculate rotation vectors
	var _rightx		= dsin(_yaw);
	var _righty		= dcos(_yaw);
	var _rightz		= 0;	
	
	var _upx		= -dcos(_yaw)		* dsin(_pitch);
	var _upy		= dsin(_yaw)		* dsin(_pitch);
	var _upz		= dcos(_pitch);
	
	var _forwardx	= dcos(_yaw)		* dcos(_pitch);	
	var _forwardy	= -dsin(_yaw)		* dcos(_pitch);	
	var _forwardz	= dsin(_pitch);	
	
	
	//Calculate translation vectors
	var _translatex	= -Dot3d(_x,_y,_z, _rightx, _righty, _rightz);
	var _translatey	= -Dot3d(_x,_y,_z, _upx, _upy, _upz);
	var _translatez	= -Dot3d(_x,_y,_z, _forwardx, _forwardy, _forwardz);
	
	
	//Assign vectors to matrix
	var _m = matrix_build(0,0,0,0,0,0,0,0,0); //GameMaker needs to know that this variable is a matrix.
	
	_m[0]	= _rightx;		_m[1]	= _upx;			_m[2]	= _forwardx;	_m[3]	= 0;	
	_m[4]	= _righty;		_m[5]	= _upy;			_m[6]	= _forwardy;	_m[7]	= 0;	
	_m[8]	= _rightz;		_m[9]	= _upz;			_m[10]	= _forwardz;	_m[11]	= 0;
	_m[12]	= _translatex;	_m[13]	= _translatey;	_m[14]	= _translatez;	_m[15]	= 1;	

	return _m;
}