///@arg x
///@arg y
///@arg z
///@arg color
///@arg intensity
///@arg range
///@arg static
///@arg castShadows
///@arg smoothShadows
{
	var _x				= argument0;
	var _y				= argument1;
	var _z				= argument2;
	var _color			= argument3;
	var _intensity		= argument4;
	var _range			= argument5;
	var _static			= argument6;
	var _castShadows	= argument7;
	var _smoothShadows	= argument8;
	
	//Create light
	var _light = instance_create_layer(_x, _y, "Light", objPointLight);
	
	//Assign attributes
	_light.z				= _z;
	_light.color			= _color;
	_light.intensity		= _intensity;
	_light.range			= _range;
	_light.static			= _static;
	_light.castShadows		= _castShadows;
	_light.smoothShadows	= _smoothShadows;
	
	//Return the instance id
	return _light;
}