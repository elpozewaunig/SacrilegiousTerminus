extends Node3D

@export var timer: Timer
@export var timerLabel: Label

var inLevel: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(300) # 5min = 300sec
	timer.start(10) # 5min = 300sec
	inLevel = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timerLabel.text = "%02d:%02d" % timer.getTimeFromTimer()


func getSignalThatLevelStarts() -> void:
	inLevel = true


func _on_round_manager_player_won() -> void:
	inLevel = false #pause countdown
	# TODO: load New scene
	
