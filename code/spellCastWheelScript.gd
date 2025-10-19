extends Node3D

@export var innerRing: Node3D 
@export var middleRing: Node3D
@export var outerRing: Node3D

@export var touchInput: TouchInputHandler

var rings: Array
var shifts: Array
var currentRingIndex: int = 0

var camera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	#Segment: for simpleInputs
	# key-right turn right
	if Input.is_action_just_pressed("input-right") or touchInput.swiped_right:
		#print("right")
		rings[currentRingIndex].changeAngle(true)
		shifts[currentRingIndex] += 1
		shifts[currentRingIndex] = mod(shifts[currentRingIndex], rings[currentRingIndex].segmentCount)
	# key-left turn left
	if Input.is_action_just_pressed("input-left") or touchInput.swiped_left:
		#print("left")
		rings[currentRingIndex].changeAngle(false)
		shifts[currentRingIndex] -= 1
		# shifts[currentRingIndex] could be less than 0 und mod is falash implementiert :(
		shifts[currentRingIndex] = mod(shifts[currentRingIndex], rings[currentRingIndex].segmentCount)
	# enter, next ring mod ringCount
	if Input.is_action_just_pressed("input-next") or touchInput.swiped_up:
		#print(shifts[currentRingIndex])
		#print("next")
		currentRingIndex -= 1
		currentRingIndex %= rings.size() # standart mod is ok currentRingIndex >= 0
		#print("currentRingIndex: ", currentRingIndex)
	
	if Input.is_action_just_pressed("input-before") or touchInput.swiped_down:
		currentRingIndex += 1
		currentRingIndex = mod(currentRingIndex, rings.size())
		
	
	
	
	# segment for parallel Inputs
	if Input.is_action_just_pressed("innerWheelLeft"):
		rings[0].changeAngle(false)
		shifts[0] -= 1
		shifts[0] = mod(shifts[0], rings[0].segmentCount)
	
	if Input.is_action_just_pressed("innerWheelRight"):
		rings[0].changeAngle(true)
		shifts[0] += 1
		shifts[0] = mod(shifts[0], rings[0].segmentCount)
		
	if Input.is_action_just_pressed("middleWheelLeft") && rings.size() > 1:
		rings[1].changeAngle(false)
		shifts[1] -= 1
		shifts[1] = mod(shifts[1], rings[1].segmentCount)
		
	if Input.is_action_just_pressed("middleWheelRight") && rings.size() > 1:
		rings[1].changeAngle(true)
		shifts[1] += 1
		shifts[1] = mod(shifts[1], rings[1].segmentCount)
	
	if Input.is_action_just_pressed("outerWheelLeft") && rings.size() > 2:
		rings[2].changeAngle(false)
		shifts[2] -= 1
		shifts[2] = mod(shifts[2], rings[2].segmentCount)
	
	if Input.is_action_just_pressed("outerWheelRight") && rings.size() > 2:
		rings[2].changeAngle(true)
		shifts[2] += 1
		shifts[2] = mod(shifts[2], rings[2].segmentCount)
	
	
	
		
func mod(a: int, b:int) -> int:
	assert(b > 0, "b has to be greater than 0")
	while a < 0:
		a+=b
		
	return a%b
