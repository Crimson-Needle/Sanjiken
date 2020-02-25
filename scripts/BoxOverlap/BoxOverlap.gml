///@desc Test if two boxes overlap eachother
///@arg x1
///@arg y1
///@arg	z1
///@arg	x2
///@arg	y2
///@arg	z2
///@arg	x3
///@arg	y3
///@arg	z3
///@arg	x4
///@arg	y4
///@arg	z4
{
	var _x1 = argument[0];
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
	
	if (
		_x2 > _x3 && _x1 < _x4 &&
		_y2 > _y3 && _y1 < _y4 &&
		_z2 > _z3 && _z1 < _z4
	) {
		return true;
	}
		
	return false;
}