///@desc Performs a raycast and returns an array of intersections. Intersections are always ordered from closest to furthest. Returns -1 if no intersections are detected.
///@arg x1
///@arg y1
///@arg z1
///@arg x2
///@arg y2
///@arg z2
///@arg object_index

/*
	The specified object_index MUST have initialised a bounding box via BoundingBoxInit() in order for this script to function.
	The parEntity object initialises a bounding box in its create event. So, using instances that inherit from parEntity is generally safe.
*/

{
	var _x1				= argument0;
	var _y1				= argument1;
	var _z1				= argument2;
	var _x2				= argument3;
	var _y2				= argument4;
	var _z2				= argument5;
	var _objectIndex	= argument6;
	
	
	var _orderedCollisions	= ds_priority_create(); 
	
	for(var _i = 0; _i < instance_number(_objectIndex); _i ++) {
		
		//Test an intersection between the specified ray and this object's box collider
		var _o	= instance_find(_objectIndex, _i);
		
		var _rayHit	= RayBoxIntersect(
			_x1, _y1, _z1, _x2, _y2, _z2, 
			_o.x + _o.bboxx1, _o.y + _o.bboxy1, _o.z + _o.bboxz1, 
			_o.x + _o.bboxx2, _o.y + _o.bboxy2, _o.z + _o.bboxz2
		);
		
		
		if (_rayHit != -1) {
			
			//Use the ray's time of intersection to find the point of collision
			var _point = array_create(3);
			_point[@ X] = _x1 + ((_x2 - _x1) * _rayHit);
			_point[@ Y] = _y1 + ((_y2 - _y1) * _rayHit);
			_point[@ Z] = _z1 + ((_z2 - _z1) * _rayHit);
	
			//Use point of collision to determine normal of collision
			var _normal = array_create(3);
			_normal[@ X] = (_point[X] > _o.x + _o.bboxx1) - (_point[X] < _o.x + _o.bboxx2);
			_normal[@ Y] = (_point[Y] > _o.y + _o.bboxy1) - (_point[Y] < _o.y + _o.bboxy2);
			_normal[@ Z] = (_point[Z] > _o.z + _o.bboxz1) - (_point[Z] < _o.z + _o.bboxz2);
			
			var _collisionData = array_create(3);
			_collisionData[@ COLLISION_OBJECT]	= _o.id;
			_collisionData[@ COLLISION_POINT]		= _point;
			_collisionData[@ COLLISION_NORMAL]	= _normal;
			
			//Order intersections by distance from ray origin
			ds_priority_add(_orderedCollisions, _collisionData, _rayHit);
			
		}
		
	}
	
	
	//Transfer contents of the ordered collisions into an array that can be returned
	var _collisions = array_create(ds_priority_size(_orderedCollisions));
	
	for (var _i = 0; _i < ds_priority_size(_orderedCollisions); _i ++) {
		_collisions[_i] = ds_priority_delete_min(_orderedCollisions);
	}
	
	
	//Cleanup and return
	ds_priority_destroy(_orderedCollisions);
	
	if (array_length_1d(_collisions) > 0)
		return _collisions;
	else
		return -1;
}