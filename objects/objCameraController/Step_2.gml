///@desc Build View Matrix
{
	if (instance_exists(g.mainCameraObject)) {
		var _view = MatrixBuildViewFromAngle(
			g.mainCameraObject.x, g.mainCameraObject.y, g.mainCameraObject.z, 
			g.mainCameraObject.yaw, g.mainCameraObject.pitch
		);
		camera_set_view_mat(g.mainCamera, _view);
	}
}