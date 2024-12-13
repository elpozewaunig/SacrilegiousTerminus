extends Node3D

@export var innerRing: Node3D 
@export var middleRing: Node3D
@export var outerRing: Node3D

var rng = RandomNumberGenerator.new()

var rings: Array
var shifts: Array

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
	if Input.is_action_just_pressed("temporaryNewSpinCommand"):
		spin()
	
		
func spin():
	for currentRingIndex in range(rings.size()):
		var currentRing = rings[currentRingIndex]
		var segmentCount = currentRing.segmentCount
		var shiftCount = rng.randi_range(0, segmentCount)
		shifts[currentRingIndex] = shiftCount
		print(shiftCount)
		
		#TODO: implement fancy verwirrendes drehen von gegnerwheel, 
		# das bei "shiftcount" endet
		# temp start
		if shiftCount == 0:
			shiftCount = segmentCount
		for _i in range(shiftCount):
			currentRing.changeAngle(true)
		# temp end
		
		
		
