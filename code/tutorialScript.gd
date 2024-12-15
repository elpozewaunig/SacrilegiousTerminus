extends CanvasLayer

signal closeTutorial()

@onready var button: Button = $DialogContainer/DialogBox/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(self.closeTutorial.emit)
