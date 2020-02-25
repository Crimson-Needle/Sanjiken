{
	if (instance_exists(g.mainCameraObject))
		return g.mainCameraObject.yaw;
	else
		return undefined;
}