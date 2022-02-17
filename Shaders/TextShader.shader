#shader vertex

#version 330 core

layout(location = 0) in vec4 position;
layout(location = 1) in vec2 texCoord;

out vec2 v_TexCoord;

uniform float sizeCoef;
uniform vec2 offset;

void main()
{
	vec4 offsetbutgood = vec4(offset, 0.0, 0.0);
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

uniform vec3 Text_Color;
uniform sampler2D u_Texture;

void main()
{
	vec4 texColor = texture(u_Texture, v_TexCoord);
	if (texColor.r >= 0.27 && texColor.g >= 0.07 && texColor.b >= 0.27 && texColor.r <= 0.29 && texColor.g <= 0.09 && texColor.b <= 0.29)
	{
		texColor.r = Text_Color.r;
		texColor.g = Text_Color.g;
		texColor.b = Text_Color.b;
	}
	color = texColor;
}