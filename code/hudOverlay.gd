extends Control

signal dialogCompleted()

@onready var dialogLayer: CanvasLayer = $"%DialogLayer"
@onready var ingameLayer: CanvasLayer = $"%IngameLayer"
@onready var textureProgressBar: TextureProgressBar = $"%FightProgressBar"
@onready var timerLabel: Label = $"%TimerLabel"

#var dialog: Array[DialogOption] = [
	#DialogOption.new(DialogOption.DIALOG_ENTITY.NARRATOR, "It was a beautiful day in a village when suddenly a deafening sound cracked the silence and a black violet crack opened in the sky. 
#A man looked up into the sky and started to smile."),
	#DialogOption.new(DialogOption.DIALOG_ENTITY.PLAYER, "Finally the day I have long awaited has arrived. The rift is opening and Satan is casting his will upon the world. But First i should go to the church and 
#get rid of the Priest of this town. I don’t want any interferance when the new Lord assends to the earth. "),
	#DialogOption.new(DialogOption.DIALOG_ENTITY.ENEMY, "My good child, what brings you here today? "),
	#DialogOption.new(DialogOption.DIALOG_ENTITY.PLAYER, "I am here to help our Supremelord from the underworld Satan himself")
#]

func showDialog(dialog: Array[DialogOption], showFullscreen: bool) -> void:
	dialogLayer.init(dialog, showFullscreen)
	dialogLayer.visible = true


func _on_dialog_layer_dialog_completed() -> void:
	dialogLayer.visible = false
	dialogCompleted.emit()
	#TODO: Remove after tests
	#displayIngameHud()

	
func displayIngameHud() -> void:
	ingameLayer.visible = true

	
func hideIngameHud() -> void:
	ingameLayer.visible = false

#var counter = 0;	
#func _input(event: InputEvent) -> void:
	##TODO: Remove after tests, should be triggered by signal
	#if Input.is_action_just_released("input-before"):
		#counter += 1
		#showDialog(dialog, counter)
		#hideIngameHud();


func _on_round_manager_update_progress_bar_to(score: float, maxScore: int) -> void:
	textureProgressBar.update(score, maxScore)
	
	
func _on_game_manager_update_the_final_countdown(timeArray: Array) -> void:
	timerLabel.update(timeArray)
