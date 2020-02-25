{	
	if (!physIsKinematic) {

#region Movement and Physics

		//Remember previous coordinates
		physPrevx = x;
		physPrevy = y;
		physPrevz = z;


		//Gravity
		physGrounded = !PlaceFree3d(x, y, z-1);
		
		if (!physGrounded) {
			if (physVelz > -g.physTerminal)
				physVelz = Approach(physVelz, -g.physTerminal, g.physGravity * physGravityFactor * DeltaTimeSeconds());
		}


		//Calculate velocity lengths
		physSpeed2d	= Length3d(physVelx, physVely, physVelz);
		physSpeed3d = Length2d(physVelx, physVely);


		//Friction
		var _frictionScalar = physGrounded ? physGroundFriction : physAirFriction;	
		var _fricx = abs(physVelx/physSpeed2d) * _frictionScalar;
		var _fricy = abs(physVely/physSpeed2d) * _frictionScalar;
	
		physVelx = Approach(physVelx, 0, _fricx * DeltaTimeSeconds());
		physVely = Approach(physVely, 0, _fricy * DeltaTimeSeconds());
			
			
		//Final velocity and movement		
		x += physVelx * DeltaTimeSeconds();
		y += physVely * DeltaTimeSeconds();
		z += physVelz * DeltaTimeSeconds();

#endregion

#region Collision Resolution

		//Reset collision data
		physCollision = -1;

		//Test and resolve collisions with solid entities
		if (physCanCollide) {
			
			for (var _i = 0; _i < instance_number(parEntity); _i++) {
				
				var _o = instance_find(parEntity, _i);
				
				if (!_o.physIsSolid)
					continue;
				if (!_o.physCanCollide)
					continue;
				if (_o == id)
					continue;
				
				
				if (BoxOverlap(
				x+bboxx1, y+bboxy1, z+bboxz1, x+bboxx2, y+bboxy2, z+bboxz2,
				_o.x+_o.bboxx1,	_o.y+_o.bboxy1,	_o.z+_o.bboxz1, _o.x+_o.bboxx2, _o.y+_o.bboxy2, _o.z+_o.bboxz2
				)) {
				
					physCollision = EntityCollisionGetData(_o, true);
				
				}
			}
		}
		
#endregion

	}
}