extends CanvasLayer

signal closeTutorial()

@onready var button: Button = $"%GotItBtn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(self.closeTutorial.emit)
