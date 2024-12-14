extends MeshInstance3D

var current_axis = Vector3(1, 0, 0)  # Starting axis
var target_axis = Vector3(1, 0, 0)  # Axis to blend towards
var blend_speed = 8.0  # Speed of blending between axes (higher is more chaotic)
var rot_speed = 80

func _ready():
	randomize()  # Seed randomness

func _process(delta):
	# Gradually blend towards the target axis for smooth swinging
	current_axis = current_axis.lerp(target_axis, blend_speed * delta).normalized()

	# Rotate smoothly around the current axis
	var rotation_angle = deg_to_rad(rot_speed) * delta  # 60 degrees per second
	rotate(current_axis, rotation_angle)

	# Occasionally pick a new random target axis
	if randf() < 0.05:  # Small probability of switching target axis per frame
		_choose_new_target_axis()

func _choose_new_target_axis():
	# Generate a completely random axis
	target_axis = Vector3(
		randf_range(-1, 1),
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
