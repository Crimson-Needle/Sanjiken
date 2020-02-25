///@desc Returns true if this entity's bounding box does not overlap another solid entity at the specified location
///@arg x
///@arg y
///@arg z
{
	var _x = argument0;
	var _y = argument1;
	var _z = argument2;
	
	for (var _i = 0; _i < instance_number(parEntity); _i ++) {
		var _o = instance_find(parEntity, _i);
	
		if (!_o.physIsSolid)
			continue;
	
		if (!_o.physCanCollide)
			continue;
		
		if (_o == id)
			continue;
	
		//Test bounding box collision
		if (BoxOverlap(
			_x+bboxx1, _y+bboxy1, _z+bboxz1, _x+bboxx2, _y+bboxy2, _z+bboxz2,
			_o.x+_o.bboxx1,	_o.y+_o.bboxy1,	_o.z+_o.bboxz1, _o.x+_o.bboxx2, _o.y+_o.bboxy2, _o.z+_o.bboxz2
		)) {
			return false;
		}
	}
	
	return true;
}