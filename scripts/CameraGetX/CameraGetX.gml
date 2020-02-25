{
	if (instance_exists(g.mainCameraObject))
		return g.mainCameraObject.x;
	else
		return undefined;
}