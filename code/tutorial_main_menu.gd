extends CanvasLayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_back_to_menu_btn_pressed()

func _on_back_to_menu_btn_pressed() -> void:
	SceneManager.change_scene(SceneManager.mainMenuSene)
