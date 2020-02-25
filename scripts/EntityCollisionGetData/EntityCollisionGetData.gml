///@desc Returns an array containing all the relevant information about this collision between entities. Resolves collisions if specified.
///@arg instance_id
///@arg resolve_collision
{
	
	var _o				= argument0;
	var _doesResolve	= argument1;
	
	var _collision	= array_create(3);
	var _point		= array_create(3);
	var _normal		= array_create(3);
			
			
	//Find axis of shortest penetration. We can use this to find all the information about this collision.
	var _xpen1 = abs((_o.x+_o.bboxx2) - (x+bboxx1));	var _xpen2 = abs((_o.x+_o.bboxx1) - (x+bboxx2));
	var _ypen1 = abs((_o.y+_o.bboxy2) - (y+bboxy1));	var _ypen2 = abs((_o.y+_o.bboxy1) - (y+bboxy2));
	var _zpen1 = abs((_o.z+_o.bboxz2) - (z+bboxz1));	var _zpen2 = abs((_o.z+_o.bboxz1) - (z+bboxz2));
			
	var _shortest = min(_xpen1, _xpen2, _ypen1, _ypen2, _zpen1, _zpen2);
			
			
	//Use axis of shortest penetration to find collision normal.
	_normal[@ X] = 0;
	_normal[@ Y] = 0;
	_normal[@ Z] = 0;
			
	switch (_shortest) {
		case _xpen1:
			_normal[@ X] = 1;
		break;
				
		case _xpen2:
			_normal[@ X] = -1;
		break;
				
		case _ypen1:
			_normal[@ Y] = 1;
		break;
				
		case _ypen2:
			_normal[@ Y] = -1;
		break;
				
		case _zpen1:
			_normal[@ Z] = 1;
		break;
				
		case _zpen2:
			_normal[@ Z] = -1;
		break;
	}
			
	
	//Use collision normal to resolve this collision
	if (_doesResolve) {
		
		if (_normal[X] != 0) {
			physVelx = 0;
			x += _normal[X] * min(_xpen1, _xpen2);
		}
		
		if (_normal[Y] != 0) {
			physVely = 0;
			y += _normal[Y] * min(_ypen1, _ypen2);
		}
		
		if (_normal[Z] != 0) {
			physVelz = 0;
			z += _normal[Z] * min(_zpen1, _zpen2);
		}
		
	}
	
			
	//Use collision normal and penetration depths to find point of collision
	_point[@ X] = 0;
	_point[@ Y] = 0;
	_point[@ Z] = 0;
		
	
	//Build collision data and return
	_collision[COLLISION_OBJECT]	= _o;
	_collision[COLLISION_POINT]		= _point;
	_collision[COLLISION_NORMAL]	= _normal;
	
	return _collision;
}