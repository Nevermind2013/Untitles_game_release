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

uniform vec4 u_Color;
uniform sampler2D u_Texture;

void main()
{
	vec4 texColor = texture(u_Texture, v_TexCoord);
	color = texColor;
}