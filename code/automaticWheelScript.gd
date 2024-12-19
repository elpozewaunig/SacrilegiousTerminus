extends Node3D

@export var innerRing: Node3D 
@export var middleRing: Node3D
@export var outerRing: Node3D

@export var color:Color
@export var elements:Array[Node3D]
@export var sprites:Array[Sprite3D]
@export var particles: Array[RigidBody3D]

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
	
	#get_child(0).get_child(0).modulate = color 
	for i in range(0,elements.size()):
		for j in range(1,elements[i].get_child_count()):
			elements[i].get_child(j).get_child(0).modulate = color
	for sp in sprites: 
		sp.modulate=color
	#for particle in particles: 
		#particle.get_child(1).draw_pass_1.material.emission=color

		
func spin():
	for currentRingIndex in range(rings.size()):
		var currentRing = rings[currentRingIndex]
		var segmentCount = currentRing.segmentCount
		var shiftCount = rng.randi_range(0, segmentCount)
		shifts[currentRingIndex] += shiftCount
		shifts[currentRingIndex] %= segmentCount
		#print(shiftCount)
		
		#TODO: implement fancy verwirrendes drehen von gegnerwheel, 
		# das bei "shiftcount" endet
		# temp start 	
		
		var stupidTempVariable = getFancyShiftcount(shiftCount, segmentCount)
		shiftCount = stupidTempVariable[0]
		var direction = bool(stupidTempVariable[1])
		
		for _i in range(shiftCount):
			currentRing.changeAngle(direction)
		# temp end
		
func getFancyShiftcount(shiftCount: int, segmentCount: int) -> Array:
	var direction = randi_range(0, 1) # 0 false (left), 1 true(right)
	
	if shiftCount == 0:
		shiftCount = segmentCount
	
	if direction == 0:
		# du hast problem, jetzt kommt Mathe
		shiftCount = segmentCount - shiftCount #pls be the right formula
	
	if (randi_range(1, 10) > 5):
		shiftCount += segmentCount
		
	while (randi_range(1, 10) > 8):
		shiftCount += segmentCount
	
		
	return [shiftCount, direction]
		
		
