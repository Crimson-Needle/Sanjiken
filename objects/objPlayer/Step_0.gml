///@desc Movement and camera controls
{
	event_inherited();
	
	
	//Controls
	var _xinput = (InputGetHold(INPUT.RIGHT) || InputGetHold(INPUT.ALT_RIGHT))	- (InputGetHold(INPUT.LEFT) || InputGetHold(INPUT.ALT_LEFT));
	var _yinput = (InputGetHold(INPUT.DOWN)	 || InputGetHold(INPUT.ALT_DOWN))	- (InputGetHold(INPUT.UP)	|| InputGetHold(INPUT.ALT_UP)	);
	
	var _xinputCam = g.mouse_xspd;
	var _yinputCam = g.mouse_yspd;
	
	var _zoomInput = mouse_wheel_down() - mouse_wheel_up();
	
	
	//Movement
	if (_xinput != 0 || _yinput != 0) {
		
		//Rotate movement direction to be relative to the camera's facing direction
		var _moveDir = Rotate2d(_xinput, _yinput, CameraGetYaw()+270);
		_moveDir = Normalize2d(_moveDir[X], _moveDir[Y]);
	
		//Accelerate to top speed
		var _accel	= (physGrounded ? playerGroundAcceleration : playerAirAcceleration) * DeltaTimeSeconds();
		
		if (Dot2d(physVelx, physVely, _moveDir[X], _moveDir[Y]) < playerMaxMoveSpeed) {
			physVelx += _moveDir[X] * _accel;
			physVely += _moveDir[Y] * _accel;
		}
	
		//Temporarily disable friction while accelerating
		physGroundFriction	= 0;
		physAirFriction		= 0;
	}
	else {
		//Re-enable friction when not accelerating
		physGroundFriction	= playerGroundFriction;
		physAirFriction		= playerAirFriction;
	}
	
	
	//Jumping
	if (InputGetPressed(INPUT.JUMP)) {
		if (physGrounded) {
			physVelz = 256;
			audio_play_sound(sndJump, 100, false);
		}
	}
	
	
	//Control camera
	if (g.cursorLock) {
		playerCamera.yaw	-= _xinputCam*camSensitivity;
		playerCamera.pitch	-= _yinputCam*camSensitivity;
		playerCamera.pitch	= clamp(playerCamera.pitch, -90, 90);
	}
	
	camLength += _zoomInput * camZoomStep;
	camLength =	clamp(camLength, camLengthMin, camLengthMax);
	
	var _toCamDirx = Dirx3d(playerCamera.yaw, playerCamera.pitch);
	var _toCamDiry = Diry3d(playerCamera.yaw, playerCamera.pitch);
	var _toCamDirz = Dirz3d(playerCamera.pitch);
	
	var _length = camLength;
	
	var _ray = Raycast(x, y, z, x+_toCamDirx*-_length, y+_toCamDiry*-_length, z+_toCamDirz*-_length, objBox);
	if (_ray != -1) {
		
		//Get point of cloeset intersection
		var _closest = _ray[0];
		var _point = _closest[COLLISION_POINT];
		
		//Set camera destination to intersection point
		_length = max(0, Length3d(x - _point[X], y - _point[Y], z - _point[Z]) - 8);
	}
	
	playerCamera.x = x + _toCamDirx * -_length;
	playerCamera.y = y + _toCamDiry * -_length;
	playerCamera.z = z + _toCamDirz * -_length;
	
	
	//Collect gems
	var _gemCollide = EntityCollision(x, y, z, objGem);
	if (_gemCollide != -1) {
		
		for (var _i = 0; _i < array_length_1d(_gemCollide); _i ++) {
			var _collision	= _gemCollide[_i];
			
			with (_collision[COLLISION_OBJECT])
				instance_destroy();
				
			audio_play_sound(sndGet, 100, false);
		}
		
	}
	
	//Land on solid ground
	if (physCollision != -1) {
		
		var _normal = physCollision[COLLISION_NORMAL];
		if (_normal[Z] == 1)
			audio_play_sound(sndLand, 100, false);
			
	}
	
	
	//Restart
	if (InputGetPressed(INPUT.RESTART)) {
		x = xstart;
		y = ystart;
		z = zstart;
	}
}