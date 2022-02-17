#shader vertex

#version 330 core

layout(location = 0) in vec4 position;
layout(location = 1) in vec2 texCoord;

out vec2 v_TexCoord;

uniform float sizeCoef;
uniform vec2 offset;
uniform float X_axis_period;
uniform float Y_axis_period;

void main()
{
	vec2 changOff = offset;
	changOff.x += (gl_InstanceID % 3 - 1.0f) * X_axis_period;
	changOff.y += (gl_InstanceID / 3 - 1.0f) * Y_axis_period;
	vec4 offsetbutgood = vec4(changOff, 0.0, 0.0);
	vec4 result = position + offsetbutgood;
	result.x *= sizeCoef * 0.5625;
	result.y *= sizeCoef;
	result.z *= sizeCoef;
	gl_Position = result;
	v_TexCoord = texCoord;
}

#shader fragment

#version 330 core

layout(location = 0) out vec4 color;

in vec2 v_TexCoord;

uniform vec3 Team_Color;
uniform sampler2D u_Texture;

void main()
{
	vec4 texColor = texture(u_Texture, v_TexCoord);
	//For health in the future
	if (texColor.r >= 0.9 && texColor.g >= 0.4 && texColor.b >= -0.1 && texColor.r <= 1.1 && texColor.g <= 0.6 && texColor.b <= 0.1)
	{
		//vec4 texColor = vec4(Team_Color, 1.0f);
		texColor.r = Team_Color.r;
		texColor.g = Team_Color.g;
		texColor.b = Team_Color.b;
	}
	else if (texColor.b >= 0.9 && texColor.g >= 0.4 && texColor.r >= -0.1 && texColor.b <= 1.1 && texColor.g <= 0.6 && texColor.r <= 0.1)
	{
		//vec4 texColor = vec4(Team_Color, 1.0f);
		texColor.r = Team_Color.r;
		texColor.g = Team_Color.g;
		texColor.b = Team_Color.b;
	}
	color = texColor;
}