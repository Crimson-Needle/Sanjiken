{
	if (instance_exists(g.mainCameraObject))
		return g.mainCameraObject.y;
	else
		return undefined;
}