extends Node3D


func _on_round_manager_player_won() -> void:
	SceneManager.change_scene(SceneManager.countrySideCutScene, true)
