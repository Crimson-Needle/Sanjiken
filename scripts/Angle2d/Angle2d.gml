///@desc Get the angle between 2 vectors
///@arg x1
///@arg y1
///@arg x2
///@arg y2
{
	var _x1 = argument0;
	var _y1 = argument1;
	var _x2 = argument2;
	var _y2 = argument3;
	
	var _top = dot_product(_x1, _y1, _x2, _y2);
	var _bottom = Length2d(_x1, _y1) * Length2d(_x2, _y2);
	
	return darccos(_top/_bottom);
}