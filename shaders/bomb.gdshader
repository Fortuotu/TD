shader_type spatial;

uniform sampler2D my_texture;
uniform float t : hint_range(0, 1.0);

void fragment() {
    vec4 texel = texture(my_texture, UV);
    ALBEDO = mix(texel.rgb * 0.1, vec3(1.0, 0.0, 0.0), t * 0.3);
}
