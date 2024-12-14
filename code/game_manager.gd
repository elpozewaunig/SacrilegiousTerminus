extends Node3D

signal updateTheFinalCountdown(timeArray: Array)

@export var timer: Timer
@export var fightSceneList: Array[Node3D]

var inLevel: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(300) # 5min = 300sec
	timer.start(10) # 5min = 300sec
	inLevel = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateTheFinalCountdown.emit(timer.getTimeFromTimer())
	


func getSignalThatLevelStarts() -> void:
	inLevel = true


func _on_round_manager_player_won() -> void:
	inLevel = false #pause countdown
	# TODO: load New scene
	
