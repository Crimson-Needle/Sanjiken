//Constants
#define MAX_LIGHTS 8

//Information from vertex shader
varying vec2 v_texcoord;
varying vec4 v_vertColour;
varying vec3 v_worldPos;
varying vec3 v_normal;
varying vec4 v_sunSpacePos;
varying mat3 v_TBN;

//External data
uniform int u_numberOfLights;
uniform vec3 u_camPos;
uniform vec3 u_objectWorldPos;
uniform vec3 u_ambientCol;
uniform float u_viewFar;
uniform vec2 u_pointShadowMapTexelSize;

//Point light properties
uniform float u_lightx[MAX_LIGHTS];
uniform float u_lighty[MAX_LIGHTS];
uniform float u_lightz[MAX_LIGHTS];

uniform float u_lightr[MAX_LIGHTS];
uniform float u_lightg[MAX_LIGHTS];
uniform float u_lightb[MAX_LIGHTS];

uniform float u_lightRange[MAX_LIGHTS];
uniform float u_lightIntensity[MAX_LIGHTS];

uniform int u_lightCastShadows[MAX_LIGHTS];
uniform int u_lightSmoothShadows[MAX_LIGHTS];

//Material properties
uniform float u_specScale;
uniform float u_specPower;
uniform float u_diffuseScale;
uniform float u_luminosity;
uniform float u_reflectScale;

//Texture maps
uniform sampler2D u_pointShadowMap;
uniform sampler2D u_specMap;
uniform sampler2D u_normalMap;
uniform sampler2D u_cubeMap;

//Booleans
uniform int u_useSpecMap;
uniform int u_useNormalMap;
uniform int u_useCubeMap;
uniform int u_recieveShadows;

#region Color To Data

	/*
	A lot of information is lost when converting a 12 byte color vector into a 3 byte color value.
	This script helps preserve some of that information
	*/

float colorToData(vec3 color) {
	float r = color.r;
	float g = color.g * 256.0;
	float b = color.b;
	
	return (r * 255.0) + (g * 255.0) + b;
}
#endregion

#region Cube To UV
	/*
		Cube 2 UV script by xygthop3
		https://marketplace.yoyogames.com/assets/1023/skybox-cubemap-reflections-3d
	
		Used to convert a directional vector inside a theoretical textured cube into a 2D texture coordinate.
	*/

	vec2 cube2uv(vec3 eyePos)
	{
	    vec2 uv;
	    vec3 spacePos=eyePos;

	    if(spacePos.x<0.0){spacePos.x=-spacePos.x;}
	    if(spacePos.y<0.0){spacePos.y=-spacePos.y;}
	    if(spacePos.z<0.0){spacePos.z=-spacePos.z;}

		if(spacePos.x>=spacePos.y&&spacePos.x>=spacePos.z)
		{
			if(eyePos.x>0.0) //LEFT
			{
				uv.x=0.125;
				uv.y=0.75;
				uv.x+=eyePos.y/eyePos.x*0.125;
				uv.y-=eyePos.z/eyePos.x*0.25;
			}
			else //RIGHT
			{
				uv.x=0.625; 
				uv.y=0.75;
				uv.x+=eyePos.y/eyePos.x*0.125;
				uv.y+=eyePos.z/eyePos.x*0.25;
			}                      
		}
                       
		if(spacePos.y>spacePos.x&&spacePos.y>=spacePos.z)
		{
			if(eyePos.y>0.0) //FRONT
			{
				uv.x=0.375;
				uv.y=0.75;
				uv.x-=eyePos.x/eyePos.y*0.125;
				uv.y-=eyePos.z/eyePos.y*0.25;

			}
			else //BACK
			{
			    uv.x=0.375;
			    uv.y=0.25;
			    uv.x-=eyePos.x/eyePos.y*0.125;
			    uv.y+=eyePos.z/eyePos.y*0.25;
			}
		}


		if(spacePos.z>spacePos.x&&spacePos.z>spacePos.y)
		{
			if(eyePos.z>0.0) //TOP
		    {
			    uv.x=0.625;
			    uv.y=0.25;
			    uv.x-=eyePos.x/eyePos.z*0.125;
			    uv.y+=eyePos.y/eyePos.z*0.25;
		    }
		    else  //BOTTOM
			{ 
		        uv.x=0.125;
		        uv.y=0.25;
		        uv.x+=eyePos.x/eyePos.z*0.125;
		        uv.y+=eyePos.y/eyePos.z*0.25;
		   }
		}

		return uv;
	}

#endregion

#region Sample Map
	float sampleShadowMap(sampler2D map, vec2 uv, vec2 texelSize, int sampleSize, float dist, float bias) {
		float value = 0.0;
		
		//Take multiple samples from the shadowmap to create smoother shadows
		for (int xx = -sampleSize; xx <= sampleSize; xx++) {
			for (int yy = -sampleSize; yy <= sampleSize; yy++) {
				//Get sample
				vec2 sampleOffset = vec2(float(xx), float(yy)) * texelSize;
				vec3 sample = texture2D(map, uv + sampleOffset).rgb;
				float sampleValue = colorToData(sample);
			
				//Test sample depth
				if (dist - bias > sampleValue) {
					value += 1.0;
				}
			}
		}
				
		//Average out shadow scale
		if (sampleSize != 0) {
			int kernel = sampleSize*2+1;
			value = value / float((kernel) * (kernel));
		}
		
		return 1.0 - value;
	}
#endregion

#region Calculate Diffuse
	vec3 calcDiffuse(vec3 color, float intensity, vec3 lightDir, vec3 normal) {
		float scale = max(0.0, dot(lightDir, -normal));
		return color * intensity * u_diffuseScale * scale;
	}
#endregion

#region Calculate Specular
	vec3 calcSpecular(vec3 color, float intensity, vec3 lightDir, vec3 normal, vec3 viewDir) {
			float scale = pow(max(0.0, dot(reflect(lightDir, normal), -viewDir)), u_specPower);
			return color * intensity * u_specScale * scale;
	}
#endregion

#region Main
	void main()
	{
		//Calculate vectors
		vec3 viewDir = normalize(v_worldPos - u_camPos);
		
		//Calculate normal vector
		vec3 normal = v_normal;
		
		if (u_useNormalMap == 1) {
			vec3 normalMapSample = normalize(2.0 * texture2D(u_normalMap, v_texcoord).rgb - 1.0);
			normalMapSample.y *= -1.0;						//"Up" on the normal map points to +y. "Up" in Gamemaker coordinates points to -y.
			normal = normalize(v_TBN * normalMapSample);	//Transform sample with TBN matrix
		}
		
		//Get samples from texture maps
		vec4 albedo = texture2D( gm_BaseTexture, v_texcoord);
		float specMapValue = texture2D(u_specMap, v_texcoord).r;
		
		//Lighting
		vec3 diffuse	= vec3(0.0,0.0,0.0);
		vec3 specular	= vec3(0.0,0.0,0.0);
		
#region Point lighting
		for (int i = 0; i < u_numberOfLights; i++) {
			//Get light data
			vec3 lightCol		= vec3(u_lightr[i], u_lightg[i], u_lightb[i]);
			vec3 lightPos		= vec3(u_lightx[i], u_lighty[i], u_lightz[i]);
			
			float lightDist		= length(v_worldPos - lightPos);
			vec3 lightDir		= normalize(v_worldPos - lightPos);
			
			//Don't do any light calculations if this fragment is out of range.
			if (lightDist > u_lightRange[i])
				continue;
				
			//Shadows
			float shadowScale = 1.0;
			if (u_lightCastShadows[i] == 1 && u_recieveShadows == 1) {
					
				//How many samples do we take from the shadowmap? The more samples we take, the smoother the shadows become.
				int sampleSize = u_lightSmoothShadows[i];
				
				//Calculate final shadowmap UV by offsetting the global UV with the local UV
				float gridSize = ceil(sqrt(float(MAX_LIGHTS)));
				
				vec2 localShadowMapUV = cube2uv(lightDir)/gridSize;
				vec2 globalShadowMapUV = vec2(mod(float(i), gridSize), floor(float(i)/gridSize))/gridSize;
				
				vec2 shadowMapUV = globalShadowMapUV + localShadowMapUV;
				shadowScale = sampleShadowMap(u_pointShadowMap, shadowMapUV, u_pointShadowMapTexelSize, sampleSize, lightDist, 4.0);
			}
			
			//Calculate falloff
			float falloff = max(0.0, 1.0 - lightDist/u_lightRange[i]);
			
			//Calculate diffuse
			float diffuseScale = max(0.0, dot(lightDir, -normal));
			diffuse += lightCol * u_lightIntensity[i] * diffuseScale * u_diffuseScale * falloff * shadowScale;
			
			//Calculate specularity
			float specScale = pow(max(0.0, dot(reflect(lightDir, normal), -viewDir)), u_specPower);
			specular += lightCol * u_lightIntensity[i] * specScale * specMapValue * u_specScale * falloff * shadowScale;
		}
#endregion
	
		//Calculate final color with lighting
		vec3 finalColor = albedo.rgb * (u_ambientCol + diffuse + specular) + (albedo.rgb * u_luminosity);
		
		//Calculate reflection
		if (u_useCubeMap == 1) {
			vec3 cubeMapSample = texture2D(u_cubeMap, cube2uv(reflect(viewDir, normal))).rgb;
			float reflectScale = u_reflectScale * specMapValue;
			finalColor = mix(finalColor, cubeMapSample, reflectScale);
		}
		
	    gl_FragColor = vec4(finalColor, albedo.a);
	}
#endregion
