extends Node3D

var scene_path : String

var progress = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(scene_path)

func _enter_tree() -> void:
	ResourceLoader.load_threaded_request(scene_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var scene_load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(scene)
