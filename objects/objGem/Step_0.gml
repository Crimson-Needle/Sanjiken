{
	event_inherited();
	
	//Rotate bodies
	mainBody[@ DRAWABLE_LOCAL_ZROT] += rotateSpeed * DeltaTimeSeconds();
	
	smallBody1[@ DRAWABLE_LOCAL_XROT] += rotateSpeed*2 * DeltaTimeSeconds();
	smallBody1[@ DRAWABLE_LOCAL_YROT] += rotateSpeed*2 * DeltaTimeSeconds();
	smallBody1[@ DRAWABLE_LOCAL_ZROT] += rotateSpeed*2 * DeltaTimeSeconds();
	
	smallBody2[@ DRAWABLE_LOCAL_XROT] += rotateSpeed*2 * DeltaTimeSeconds();
	smallBody2[@ DRAWABLE_LOCAL_YROT] += rotateSpeed*2 * DeltaTimeSeconds();
	smallBody2[@ DRAWABLE_LOCAL_ZROT] += rotateSpeed*2 * DeltaTimeSeconds();
	
	//Set small body positions
	smallBodyYaw	+= rotateSpeed*2	* DeltaTimeSeconds();
	smallBodyPitch	+= rotateSpeed*0.5	* DeltaTimeSeconds();
	
	smallBody1[@ DRAWABLE_LOCAL_X] = Dirx3d(smallBodyYaw, smallBodyPitch)			* smallBodyLength;
	smallBody1[@ DRAWABLE_LOCAL_Y] = Diry3d(smallBodyYaw, smallBodyPitch)			* smallBodyLength;
	smallBody1[@ DRAWABLE_LOCAL_Z] = Dirz3d(smallBodyPitch)							* smallBodyLength;
	
	smallBody2[@ DRAWABLE_LOCAL_X] = Dirx3d(smallBodyYaw+180, -smallBodyPitch)		* smallBodyLength;
	smallBody2[@ DRAWABLE_LOCAL_Y] = Diry3d(smallBodyYaw+180, -smallBodyPitch)		* smallBodyLength;
	smallBody2[@ DRAWABLE_LOCAL_Z] = Dirz3d(-smallBodyPitch)						* smallBodyLength;
}								