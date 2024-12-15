extends Button

@onready var player : AudioStreamPlayer = AudioStreamPlayer.new()

@export var hover_sound : AudioStream
@export var click_sound : AudioStream

func _ready() -> void:
	add_child(player)
	player.volume_db = -10

func _on_mouse_entered() -> void:
	if is_visible_in_tree():
		print(name)
		player.stream = hover_sound
		player.play()

func _on_pressed() -> void:
	if is_visible_in_tree():
		player.stream = click_sound
		player.play()
