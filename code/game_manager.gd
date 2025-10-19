extends Node3D

signal updateTheFinalCountdown(timeArray: Array)


func getTimeFromTimer(timeLeft) -> Array:
	var minute = floor(timeLeft / 60)
	var second = int(timeLeft) % 60
	var millisecond = int((timeLeft-int(timeLeft))*100)
	return [minute, second, millisecond]

var inLevel: bool = false
var timeLeft: float = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetTimer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inLevel:
		timeLeft = editTimer(timeLeft, delta)
		sendTimerSignal()

func resetTimer() -> void:
	timeLeft = 300

func editTimer(timeLeft, delta):
	timeLeft -= delta
		
	if timeLeft <= 0:
		timeLeft = 0
		SceneManager.change_scene(SceneManager.loseScene, false)
		GameManager.stopTimer()
	
	return timeLeft

func sendTimerSignal():
	updateTheFinalCountdown.emit(getTimeFromTimer(timeLeft))

func getTimerSignal():
	return getTimeFromTimer(timeLeft)

func startTimer() -> void:
	inLevel = true


func stopTimer() -> void:
	inLevel = false #pause countdown
	
