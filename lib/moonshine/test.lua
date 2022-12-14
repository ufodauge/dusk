--[[
The MIT License (MIT)

Original code: Copyright (c) 2015 Josef Patoprsty
Port to moonshine: Copyright (c) 2017 Matthias Richter <vrld@vrld.org>

Based on work by: ioxu

https://www.love2d.org/forums/viewtopic.php?f=4&t=3733&start=120#p71099

Based on work by: Fabien Sanglard

http://fabiensanglard.net/lightScattering/index.php

Based on work from:

[Mitchell]: Kenny Mitchell "Volumetric Light Scattering as a Post-Process" GPU Gems 3 (2005).
[Mitchell2]: Jason Mitchell "Light Shaft Rendering" ShadersX3 (2004).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]] --

return function(moonshine)
    local shader = love.graphics.newShader [[
const int numlights = 3;

const vec3 gamma = vec3(2.2);
const vec3 invgamma = 1.0/gamma;

const vec3 viewdir = vec3(0.0, 0.0, 1.0);


extern vec4 Lights[6]; // max n / 2 lights

extern Image normaltexture;

extern number specpower = 25.0;
		
extern number yres;
extern number z = 0.0;
		
vec4 pow(vec4 color, vec3 exp)
{
	color.rgb = pow(color.rgb, exp);
	return color;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
	vec3 coords = vec3(pixel_coords.x, yres - pixel_coords.y, z);
				
	vec4 texcolor = pow(Texel(texture, texture_coords), gamma);

	vec4 finalcolor = pow(vec4(0.0), gamma) * texcolor;
	
	vec4 normal = Texel(normaltexture, texture_coords);
	vec3 N = normalize(normal.xyz * 2.0 - 1.0);
	
	float specvalue = normal.a; // the normal texture has the specular texture inside its alpha component
	
	for (int i = 0; i < numlights * 2; i += 2)
	{
		vec3 L = normalize(Lights[i].xyz - coords);
		number NdotL = max(dot(N, L), 0.0);
	
		vec3 R = normalize(reflect(-L, N));
		number specular = pow(max(dot(viewdir, R), 0.0), specpower);
	
		finalcolor += (texcolor * Lights[i+1] * NdotL) + (Lights[i+1] * specvalue * specular);
	}

	finalcolor.a = texcolor.a;
	
	return pow(finalcolor, invgamma);
}
    ]]


    local setters = {}
    -- setters.size = function(v)
    --   if type(v) == "number" then v = {v,v} end
    --   assert(type(v) == "table" and #v == 2, "Invalid value for `size'")
    --   shader:send("size", v)
    -- end
    -- setters.feedback = function(v)
    --   shader:send("feedback", math.min(1, math.max(0, tonumber(v) or 0)))
    -- end

    local defaults = {
    --   exposure = 0.25,
    --   decay = 0.95,
    --   density = 0.15,
    --   weight = 0.5,
    --   light_position = { 0.5, 0.5 },
    --   samples = 70
    }

    return moonshine.Effect {
      name = 'test',
      shader = shader,
      setters = setters,
      defaults = defaults
    }
end
