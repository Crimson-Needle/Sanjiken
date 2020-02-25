///@desc Initialise physics properties for this entity
///@arg can_collide
///@arg is_solid
///@arg is_kinematic
///@arg gravity_factor
///@arg ground_friction
///@arg air_friction
{
	physCanCollide	= argument0;
	physIsSolid		= argument1;
	physIsKinematic = argument2;
	
	physGravityFactor	= argument3;
	physGroundFriction	= argument4;
	physAirFriction		= argument5;
	
	physPrevx = x;
	physPrevy = y;
	physPrevz = z;
	
	physVelx = 0;
	physVely = 0;
	physVelz = 0;
	
	physSpeed2d = 0;
	physSpeed3d = 0;
	
	physGrounded = false;
	
	//In the event that a solid collision is detected in PhysUpdate(), physCollision will store the collision data for the rest of the frame.
	physCollision = -1; 
}