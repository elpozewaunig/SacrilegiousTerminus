extends TouchScreenButton

@onready var player : AudioStreamPlayer = AudioStreamPlayer.new()

@export var click_sound : AudioStream

func _ready() -> void:
	add_child(player)
	player.volume_db = -10

func _on_pressed() -> void:
	if is_visible_in_tree():
		player.stream = click_sound
		player.play()
