shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 c = vec3(1.0,1.0,1.0);
	int x = int(UV.x * 8.0 / 2.0);
	int y = int(UV.y * 60.0 / 2.0);
	if ((x+y) % 2 == 0) {
		c = vec3(0.0,0.0,0.0);
	}
	COLOR = vec4(c,UV.y);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
