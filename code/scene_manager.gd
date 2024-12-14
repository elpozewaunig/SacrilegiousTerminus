extends Node

@export_group("FightingScenes")
@export var theChurch : PackedScene
@export var theCountrySide : PackedScene
@export var theMountain : PackedScene
@export var thRift : PackedScene

@export_group("Cutscene Scenes")
@export var theChruchCutscene : PackedScene
@export var theCountrySideCutscene : PackedScene
@export var theMountainCutscene : PackedScene
@export var thRiftCutscene : PackedScene

@export_group("Settings Scenes")
@export var mainMenuSene : PackedScene

@export_group("Loading Screen")
@export var loadingScene : PackedScene

func _ready() -> void:
	change_scene(mainMenuSene)

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
