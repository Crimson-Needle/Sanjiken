{
	if (instance_exists(g.mainCameraObject))
		return g.mainCameraObject.pitch;
	else
		return undefined;
}