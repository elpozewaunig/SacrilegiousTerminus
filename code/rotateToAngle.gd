extends Node3D

var goalRotationAngle: int = 0
@export var segmentCount: int
@export var T: int = 1
var angleChange: float 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("integer_division") # is intended
	angleChange = 360/segmentCount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#rotate 
	if rotation_degrees.y < goalRotationAngle:
		@warning_ignore("integer_division") # is intended
		rotation_degrees.y += 360/T * delta
		if rotation_degrees.y > goalRotationAngle:
			rotation_degrees.y = goalRotationAngle
	elif rotation_degrees.y > goalRotationAngle:
		@warning_ignore("integer_division") # is intended
		rotation_degrees.y -= 360/T * delta
		if rotation_degrees.y < goalRotationAngle:
			rotation_degrees.y = goalRotationAngle

	
func changeAngle(changeToLeft: bool) -> void:
	if changeToLeft:
		@warning_ignore("narrowing_conversion") # is intended
		goalRotationAngle += angleChange
		#print("rotating left")
	else:
		@warning_ignore("narrowing_conversion") # is intended
		goalRotationAngle -= angleChange
		#print("rotating right")
		
	

		
func floatMod360(angle: float) -> float:
	if angle > 360:
		angle -= 360
	elif angle < 0:
		angle += 360
	
	return angle
	
