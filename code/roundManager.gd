extends Node3D

signal playerWon()
signal updateProgressBarTo(score:float , maxScore:int)

var playerSpins: Array
var opponentSpins: Array
@export var playerWheel: Node3D
@export var opponentWheel: Node3D
@export var hasProgressBar: bool
@export var timeForRoud: int

@onready var hudoverlay: Control = $HudOverlay

var ringCount: int
var wheelSizes: Array

var score:float
var timeTillNewSpin: float

var gameStarted: bool = false


const maxScore:int = 100
const segmenctCount:int = 3
const progressDuration:int = 20
const roundsTillFullToEmpty: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ringCount = playerWheel.shifts.size()
	
	wheelSizes.append(playerWheel.innerRing.segmentCount) # Law of Demeter was ist das? xd
	if ringCount > 1: # middleRing exists
		wheelSizes.append(playerWheel.middleRing.segmentCount)
	if ringCount > 2: # outerRing exists
		wheelSizes.append(playerWheel.outerRing.segmentCount) 
	
	if hudoverlay != null:
		hudoverlay.hideIngameHud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ultraCheatingMove3000"):
		playerWon.emit()
		GameManager.stopTimer()
	
	
	if !gameStarted || !GameManager.inLevel:
		return
	var eval = evaluatePosition()
	timeTillNewSpin -= delta
	#score --> #0 falash, #1 ich akzeptiere, #2 Q1-Lösung
	# 1 can be ignored for now, is for possible extensions with partial points
	
	if eval == 0 && score != 20:
		score -= (maxScore * delta / progressDuration )* getPointsDetuctionFactor(timeTillNewSpin, timeForRoud) / roundsTillFullToEmpty
		if score < 20: score = 20
	elif eval == 2 && score != maxScore-15:
		score += (maxScore * delta / progressDuration) * getBonusPointsFactor(timeTillNewSpin, timeForRoud) / roundsTillFullToEmpty
		if score>maxScore-15: score = maxScore-15
	
	if score >= maxScore-15:
		playerWon.emit()
		GameManager.stopTimer()
		
	if hasProgressBar:
		updateProgressBarTo.emit(score, maxScore)
	
	
	#update timer
	if timeTillNewSpin <= 0 || Input.is_action_just_pressed("temporaryNewSpinCommand"):
		timeTillNewSpin = timeForRoud
		opponentWheel.spin()
		
	
func evaluatePosition() -> int: #0 falash, #1 ich akzeptiere, #2 Q1-Lösung
	playerSpins = playerWheel.shifts
	opponentSpins = opponentWheel.shifts
	var currentWheelSize
	
	if ringCount == 1: # difficuly easy
		#check innerRing opposite (only one ring -> no extra rules)
		currentWheelSize = wheelSizes[0]
		var innerRingOffset = currentWheelSize/2
		
		var innerRingCorrect = evaluateRing(playerSpins[0], opponentSpins[0], currentWheelSize ,innerRingOffset)
		
		if innerRingCorrect:
			return 2
		return 0
	
	# else ring count >= 2 --> check innerRing !!extraRules
	# middle ring
	currentWheelSize = wheelSizes[1]
	
	assert(currentWheelSize%segmenctCount == 0, "Wheel Size of Middle Wheel needs to be a multiple of the segmenctCount")
	
	var segmentSize = currentWheelSize / segmenctCount
	var offset = 0
	if opponentSpins[1] < segmentSize:
		offset = wheelSizes[0]/2 # opposite of !!!inner!!!! wheel
	elif opponentSpins[1] < 2*segmenctCount: 
		offset = 1 # plus minus 1
	
	var middleCorrect = evaluateRing(playerSpins[1], opponentSpins[1], currentWheelSize, 0) # middleRing -> no offset
	
	if !middleCorrect:
		return 0
	
	# inner ring
	currentWheelSize = wheelSizes[0]
	var innerCorrect
	if offset == 1:
		# if offset is 1, we need to test +1 and -1 !!!!!
		innerCorrect = evaluateRing(playerSpins[0], opponentSpins[0], currentWheelSize, 1) 
		if !innerCorrect:
			innerCorrect = evaluateRing(playerSpins[0], opponentSpins[0], currentWheelSize, -1)
	elif offset == 0:
		innerCorrect = evaluateRing(playerSpins[0], opponentSpins[0], currentWheelSize, 0)
	else: # offset = length / 2
		innerCorrect = evaluateRing(playerSpins[0], opponentSpins[0], currentWheelSize, offset)
	
	if !innerCorrect:
		return 0
	
	if ringCount > 2: #ringcount (>)=3
		currentWheelSize = wheelSizes[2]
		var outerCorrect = evaluateRing(playerSpins[2], opponentSpins[2], currentWheelSize, 0)

		if !outerCorrect:
			return 0

	# else: all correct
	return 2
	
func evaluateRing(currentPlayerSpins, currentOpponentSpins, size, offset) -> bool:
	if currentPlayerSpins >= size || currentOpponentSpins >= size || currentPlayerSpins < 0 || currentOpponentSpins < 0:
		push_error("michi") # sehr kreativer Name, danke für den Vorschlag @seal
	
	return (currentPlayerSpins+offset)%size == currentOpponentSpins

func getPointsDetuctionFactor(timeLeft:float, intervalSize:int) -> float:
	# (1/3 nix, 2/3 ~50%, 3/4 ~minitest)
	var percentLeft = timeLeft / intervalSize * 100
	if percentLeft > 66:
		return 0
	
	if percentLeft > 33:
		return 0.5
	
	if percentLeft < 10:
		return 2
		
	return 1

func getBonusPointsFactor(timeLeft: float, intervalSize:int) -> float:
	var percentLeft = timeLeft / intervalSize * 100
	if percentLeft > 66:
		return 2
	
	if percentLeft > 50:
		return 1.5
		
	return 1
	
	
func gameStartsNow():
	score = 50
	timeTillNewSpin = 0
	if hudoverlay != null:
		hudoverlay.displayIngameHud()
	gameStarted = true
	GameManager.startTimer()
