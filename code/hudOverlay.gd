extends Control

@onready var dialogLayer: CanvasLayer = $"%DialogLayer"

@export var dialog: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showDialog(dialog: Array[String]) -> void: 
	dialogLayer.init(dialog)
	dialogLayer.visible = true

func _on_dialog_layer_dialog_completed() -> void:
	dialogLayer.visible = false
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("input-before"):
		showDialog(dialog)
