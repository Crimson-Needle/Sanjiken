#define MAX_LIGHTS 8

//Information from vertex shader
varying vec2 v_texcoord;
varying vec3 v_worldPos;
varying vec3 v_normal;
varying float v_depth;
varying mat3 v_TBN;

//External information
uniform int u_numberOfLights;
uniform float u_time;
uniform float u_viewFar;
uniform float u_screenWidth;
uniform float u_screenHeight;
uniform vec2 u_noiseTexelSize;
uniform vec3 u_cameraPos;

//Water attributes
uniform vec3 u_waterColor;
uniform vec3 u_fogColor;
uniform vec3 u_highlightColor;

uniform float u_edgeDepth;
uniform float u_specScale;
uniform float u_specPower;
uniform float u_reflectScale;
uniform float u_scrollx;
uniform float u_scrolly;
uniform float u_noisew;
uniform float u_noiseh;
uniform float u_normalw;
uniform float u_normalh;

uniform float u_colorizeDepth;
uniform float u_colorizeDepthRange;
uniform float u_fogDepth;
uniform float u_fogDepthRange;

//Point light properties
uniform float u_lightx[MAX_LIGHTS];
uniform float u_lighty[MAX_LIGHTS];
uniform float u_lightz[MAX_LIGHTS];

uniform float u_lightr[MAX_LIGHTS];
uniform float u_lightg[MAX_LIGHTS];
uniform float u_lightb[MAX_LIGHTS];

uniform float u_lightRange[MAX_LIGHTS];
uniform float u_lightIntensity[MAX_LIGHTS];

//Texture maps
uniform sampler2D u_screen;
uniform sampler2D u_depthMap;
uniform sampler2D u_noiseMap;
uniform sampler2D u_normalMap;
uniform sampler2D u_cubeMap;

//Booleans
uniform int u_useNormalMap;

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

#region Main
void main()
{
	vec3 finalColor;
	vec3 viewDir = normalize(v_worldPos - u_cameraPos);
	vec2 screenPos = vec2(gl_FragCoord.x/u_screenWidth, gl_FragCoord.y/u_screenHeight);
	
	
	
	//Get depth
	float sceneDepth	= colorToData(texture2D(u_depthMap, screenPos).rgb);
	float objectDepth	= v_depth;
	float waterDepth	= sceneDepth - objectDepth;
	
	
	
	//Get noise sample and normal sample
	vec2 timeOffset1 = vec2(u_time*u_scrollx,		u_time*u_scrolly)		* u_noiseTexelSize;
	vec2 timeOffset2 = vec2(-u_time*u_scrolly*0.6,	u_time*u_scrolly*0.3)	* u_noiseTexelSize;
	
	vec2 noiseUV1 = vec2(v_texcoord.x * u_noisew, v_texcoord.y * u_noiseh) + timeOffset1;
	vec2 noiseUV2 = vec2(v_texcoord.x * u_noisew, v_texcoord.y * u_noiseh) + timeOffset2;
	
	vec2 normalUV1 = vec2(v_texcoord.x * u_normalw, v_texcoord.y * u_normalh) + timeOffset1;
	vec2 normalUV2 = vec2(v_texcoord.x * u_normalw, v_texcoord.y * u_normalh) + timeOffset2;
	
	float noise = (
		texture2D(u_noiseMap, noiseUV1).r + 
		texture2D(u_noiseMap, noiseUV2).r
		)*0.5;
	
	vec3 normalMapSample = normalize(
		(texture2D(u_normalMap, normalUV1).rgb * 2.0 - 1.0) * 
		(texture2D(u_normalMap, normalUV2).rgb * 2.0 - 1.0)
		);
	
	//Calculate normal vector
	normalMapSample = normalize(vec3(normalMapSample.xy * 0.25, 1.0));	//Flaten the normal a little.
	normalMapSample.y *= -1.0;											//"Up" on the normal map points to +y. "Up" in Gamemaker coordinates points to -y.
	vec3 normal = normalize(v_TBN * normalMapSample);					//Transform sample with TBN matrix.
	
	
	
	//Grab screen sample
	vec2 refractPos = screenPos + normalMapSample.xy * 0.2;
	vec3 screenSample = texture2D(u_screen, refractPos).rgb;
	
	
	
	//Colorize the screen sample
	float greyScale = dot(screenSample.rgb, vec3(0.229, 0.587, 0.114));
	vec3 colorizedSample = u_waterColor * greyScale;

	float colorizeScale = smoothstep(u_colorizeDepth, u_colorizeDepth + u_colorizeDepthRange, waterDepth);
	finalColor = mix(screenSample, colorizedSample, colorizeScale);
	
	//Apply depth fog
	float fogScale = smoothstep(u_fogDepth, u_fogDepth + u_fogDepthRange, waterDepth);
	finalColor = mix(finalColor, u_fogColor, fogScale);
	
	
	
	//Calculate reflection
	vec3 reflectSample = texture2D(u_cubeMap, cube2uv(reflect(viewDir, normal))).rgb;
	finalColor = mix(finalColor, reflectSample, u_reflectScale);
	
	
	
	//Calculate lighting
	vec3 specular	= vec3(0.0,0.0,0.0);
		
		for (int i = 0; i < u_numberOfLights; i++) {
			//Get light data
			vec3 lightCol = vec3(u_lightr[i], u_lightg[i], u_lightb[i]);
			vec3 lightPos = vec3(u_lightx[i], u_lighty[i], u_lightz[i]);
			
			vec3 lightToFrag = v_worldPos - lightPos;
			vec3 lightDir = normalize(lightToFrag);
			
			float falloff = max(0.0, 1.0 - length(lightToFrag)/u_lightRange[i]);
			
			//Calculate specularity
			float specScale = pow(max(0.0, dot(reflect(normalize(lightToFrag), normal), -viewDir)), u_specPower);
			specular += lightCol * u_lightIntensity[i] * specScale * u_specScale * falloff;
		}
	finalColor += specular;
	
	
	//Define water edges
	float edgeWeight	= (1.0 - smoothstep(objectDepth, objectDepth + u_edgeDepth, sceneDepth));
	float noiseWeight	= (edgeWeight + noise) * 0.5;

	if (noiseWeight > 0.5)
		finalColor = u_highlightColor;
	
	//Owarimashita
    gl_FragColor = vec4(finalColor, 1.0);
}
#endregion