extends Node3D

var goalRotationAngle: int = 0
@export var segmentCount: int
@export var T: int = 10
var angleChange: float 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	angleChange = 360/segmentCount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#rotate 
	if rotation_degrees.y < goalRotationAngle:
		rotation_degrees.y += 360/T * delta
		if rotation_degrees.y > goalRotationAngle:
			rotation_degrees.y = goalRotationAngle
	elif rotation_degrees.y > goalRotationAngle:
		rotation_degrees.y -= 360/T * delta
		if rotation_degrees.y < goalRotationAngle:
			rotation_degrees.y = goalRotationAngle

	
func changeAngle(changeToRight: bool) -> void:
	if changeToRight:
		goalRotationAngle += angleChange
		print("rotating right")
	else:
		goalRotationAngle -= angleChange
		print("rotating left")
	

		
func floatMod360(angle: float) -> float:
	if angle > 360:
		angle -= 360
	elif angle < 0:
		angle += 360
	
	return angle
	
