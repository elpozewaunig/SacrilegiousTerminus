extends Node3D

@export var innerRing: Node3D 
@export var middleRing: Node3D
@export var outerRing: Node3D

var rings: Array
var shifts: Array
var currentRingIndex: int = 0

var camera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	if outerRing:
		rings = [innerRing, middleRing, outerRing]
		shifts = [0, 0, 0]
	elif middleRing:
		rings = [innerRing, middleRing]
		shifts = [0, 0]
	else:
		rings = [innerRing]
		shifts = [0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# key-right turn right
	if Input.is_action_just_pressed("input-right"):
		#print("right")
		rings[currentRingIndex].changeAngle(true)
		shifts[currentRingIndex] += 1
		shifts[currentRingIndex] = mod(shifts[currentRingIndex], rings[currentRingIndex].segmentCount)
	# key-left turn left
	if Input.is_action_just_pressed("input-left"):
		#print("left")
		rings[currentRingIndex].changeAngle(false)
		shifts[currentRingIndex] -= 1
		# shifts[currentRingIndex] could be less than 0 und mod is falash implementiert :(
		shifts[currentRingIndex] = mod(shifts[currentRingIndex], rings[currentRingIndex].segmentCount)
	# enter, next ring mod ringCount
	if Input.is_action_just_pressed("input-next"):
		#print(shifts[currentRingIndex])
		#print("next")
		currentRingIndex += 1
		currentRingIndex %= rings.size() # standart mod is ok currentRingIndex >= 0
		#print("currentRingIndex: ", currentRingIndex)
	
	if Input.is_action_just_pressed("input-before"):
		currentRingIndex -= 1
		currentRingIndex = mod(currentRingIndex, rings.size())
		
		
func mod(a: int, b:int) -> int:
	assert(b > 0, "b has to be greater than 0")
	while a < 0:
		a+=b
		
	return a%b
