extends CanvasLayer

@onready var exit_btn: Button = $"%Button"

func _ready() -> void:
	exit_btn.grab_focus()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("input-next"):
		_on_back_to_menu_btn_pressed()

func _on_back_to_menu_btn_pressed() -> void:
	SceneManager.change_scene(SceneManager.mainMenuSene)
