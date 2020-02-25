{
	if (instance_exists(g.mainCameraObject))
		return g.mainCameraObject.z;
	else
		return undefined;
}