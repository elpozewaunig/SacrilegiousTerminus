extends Node3D
func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		SceneManager.change_scene(SceneManager.mainMenuSene, false)
	
