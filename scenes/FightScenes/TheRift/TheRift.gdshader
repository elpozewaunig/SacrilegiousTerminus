shader_type spatial;


uniform sampler2D viewport_texture : source_color;

void fragment(){
	vec2 uv = UV;
    vec2 offset = vec2(15.0, TIME * 0.1);
    uv += offset;
	vec3 color = texture(viewport_texture, uv).rgb;
    ALBEDO = color;
    EMISSION = color * 2.0;

}