///@desc For use with entities to test a collision with another entity at the specified coordinates
///@arg x
///@arg y
///@arg z
///@arg object_index
{
	var _x				= argument0;
	var _y				= argument1;
	var _z				= argument2;
	var _objectIndex	= argument3;
	
	var _collisionList = ds_list_create();

	for (var _i = 0; _i < instance_number(_objectIndex); _i++) {
		
		var _o = instance_find(_objectIndex, _i);
			
		if (!_o.physCanCollide)
			continue;
			
		if (_o == id)
			continue; //Don't collide with self baka >:(
		
		
		//Test bounding box collision
		if (BoxOverlap(
			x+bboxx1, y+bboxy1, z+bboxz1, x+bboxx2, y+bboxy2, z+bboxz2,
			_o.x+_o.bboxx1,	_o.y+_o.bboxy1,	_o.z+_o.bboxz1, _o.x+_o.bboxx2, _o.y+_o.bboxy2, _o.z+_o.bboxz2
		)) {
			
			var _collision = EntityCollisionGetData(_o, false);
			
			//If a collision has been found, then store collision data and continue loop
			ds_list_add(_collisionList, _collision);
			continue;
		}
	}
	
	
	//No collisions found
	if (ds_list_size(_collisionList) == 0)
		return -1;

	//Return collisions as an array
	var _return = ArrayFromList(_collisionList);
	ds_list_destroy(_collisionList);
	
	return _return;
}