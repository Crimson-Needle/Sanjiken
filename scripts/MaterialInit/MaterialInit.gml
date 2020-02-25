{
	//Create the global material map
	g.materialMap = ds_map_create();
	
#region All Materials
	MaterialAdd( "Tile", 
		sprite_get_texture(texTile, 0),
		sprite_get_texture(texTile, 1),
		sprite_get_texture(texTile, 2),
		1, 1, 32, 0, 0.25
	);
	
	MaterialAdd( "Brick",
		sprite_get_texture(texBrick, 0),
		-1,
		-1,
		1, 0.1, 32, 0, 0
	);
	
	MaterialAdd( "Gem",
		sprite_get_texture(texGem, 0),
		-1,
		-1,
		1, 0, 1, 1, 0
	);
	
	MaterialAdd( "Reflective",
		sprite_get_texture(texBlack, 0),
		-1,
		-1,
		1, 1, 512, 0, 0.8
	);
#endregion

}