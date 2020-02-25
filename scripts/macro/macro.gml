	#macro g global
	#macro MAX_LIGHTS 8 //The MAX_LIGHTS constants in the material and water shaders must ALWAYS be equal to this constant
	
#region Vector
	
	#macro X 0
	#macro Y 1
	#macro Z 2
	
#endregion

#region Draw Mode

	#macro DRAW_MATERIAL		0
	#macro DRAW_VIEW_DEPTH		1
	#macro DRAW_VIEW_DISTANCE	2

#endregion

#region Drawable

	#macro DRAWABLE_MATERIAL		0
	#macro DRAWABLE_VBUFF			1
	#macro DRAWABLE_CAST_SHADOWS	2
	#macro DRAWABLE_RECIEVE_SHADOWS	3
	
	#macro DRAWABLE_LOCAL_X			4
	#macro DRAWABLE_LOCAL_Y			5
	#macro DRAWABLE_LOCAL_Z			6
	#macro DRAWABLE_LOCAL_XROT		7
	#macro DRAWABLE_LOCAL_YROT		8
	#macro DRAWABLE_LOCAL_ZROT		9
	#macro DRAWABLE_LOCAL_XSCALE	10
	#macro DRAWABLE_LOCAL_YSCALE	11
	#macro DRAWABLE_LOCAL_ZSCALE	12

#endregion

#region Material Properties

	#macro MAT_ALBEDO			0
	#macro MAT_SPEC_MAP			1
	#macro MAT_NORMAL_MAP		2	
	#macro MAT_DIFFUSE_SCALE	3
	#macro MAT_SPEC_SCALE		4	//Scale of specular shine. 0 means no specularity.
	#macro MAT_SPEC_POWER		5	//Sharpness of specular shine. Higher values create more defined shininess.
	#macro MAT_LUMINOSITY		6
	#macro MAT_REFLECT_SCALE	7

#endregion

#region Input Binds

	#macro HOLD		0
	#macro PRESS	1
	#macro RELEASE	2

	enum INPUT {
		LEFT,
		RIGHT,
		UP,
		DOWN,
		
		ALT_LEFT,
		ALT_RIGHT,
		ALT_UP,
		ALT_DOWN,
		
		JUMP,
		CROUCH,
		
		RESTART,
		
		count
	}

#endregion

#region Collision Data

	#macro COLLISION_OBJECT	0
	#macro COLLISION_POINT	1
	#macro COLLISION_NORMAL	2

#endregion