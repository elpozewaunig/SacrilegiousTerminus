extends Node3D

@export var innerRing: Node3D 
@export var middleRing: Node3D
@export var outerRing: Node3D

var rings: Array
var currentRingIndex: int = 0

var camera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	rings = [innerRing, middleRing, outerRing]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# key-right turn right
	if Input.is_action_just_pressed("input-right"):
		print("right")
		rings[currentRingIndex].changeAngle(true)
	# key-left turn left
	if Input.is_action_just_pressed("input-left"):
		print("left")
		rings[currentRingIndex].changeAngle(false)
	# enter, next ring % ringCount
	if Input.is_action_just_pressed("input-next"):
		#print("next")
		currentRingIndex += 1
		currentRingIndex %= rings.size()
		print("currentRingIndex: ", currentRingIndex)
