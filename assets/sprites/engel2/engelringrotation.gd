extends MeshInstance3D

var current_axis = Vector3(1, 0, 0)
var target_axis = Vector3(1, 0, 0) 
var lerpspeed = 8.0
var rotationspeed = 80

func _ready():
	randomize()

func _process(delta):
	# lerp garantiert
	current_axis = current_axis.lerp(target_axis, lerpspeed * delta).normalized()
	rotate(current_axis, deg_to_rad(rotationspeed) * delta)

	# Selten neue Axis
	if randf() < 0.05:  
		target_axis = Vector3(
		randf_range(-1, 1),
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
