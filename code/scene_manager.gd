extends Node

@export_group("FightingScenes")
@export var theChurchFight : PackedScene
@export var theCountrySide : PackedScene
@export var theMountain : PackedScene
@export var thRift : PackedScene

@export_group("Cutscene Scenes")
@export var introScene : PackedScene
@export var churchCutSceneTillDeathHelpMePls: PackedScene
@export var countrySideCutScene: PackedScene
@export var mountainCutScene: PackedScene
@export var riftCutScene: PackedScene
@export var outroCutScene: PackedScene

@export_group("Settings Scenes")
@export var mainMenuSene : PackedScene
@export var credits : PackedScene
@export var pauseScene : PackedScene

@export_group("Loading Screen")
@export var loadingScene : PackedScene

@export_group("endings")
@export var loseScene : PackedScene
@export var winScene : PackedScene

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func change_scene(scene: PackedScene, loading_screen: bool = false) -> void:
	print("changeing scene")
	if loading_screen:
		print("loader")
		# Create loading scene and add it as a parallel scene
		var loader = loadingScene.instantiate()
		loader.scene_path = scene.resource_path
		get_tree().root.add_child(loader)
		
		# Delete current main scene at the end of the frame
		get_tree().current_scene.queue_free()
		get_tree().current_scene = loader
	
	else:
		# Instantly load and change to scene
		get_tree().change_scene_to_packed(scene)
	
	# Make sure game is unpaused after scene switch
	#get_tree().paused = false

func quit_game():
	get_tree().quit()

func pause() -> void:
	print("pause")
#	get_tree().paused = true
	
