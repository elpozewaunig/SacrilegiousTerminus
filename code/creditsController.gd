extends Node3D

var released : bool = false

func _process(_delta: float) -> void:
	if not Input.is_anything_pressed():
		released = true
	
	if Input.is_anything_pressed() and released:
		SceneManager.change_scene(SceneManager.mainMenuSene, false)
	
