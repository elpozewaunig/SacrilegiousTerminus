extends Control

signal dialogCompleted()
signal currentEntity(entity: DialogOption.DIALOG_ENTITY)

@onready var dialogLayer: CanvasLayer = $"%DialogLayer"
@onready var ingameLayer: CanvasLayer = $"%IngameLayer"
@onready var tutorialLayer: CanvasLayer = $"%TutorialLayer"
@onready var textureProgressBar: TextureProgressBar = $"%FightProgressBar"
@onready var timerLabel: Label = $"%TimerLabel"

func showDialog(dialog: Array[DialogOption], showFullscreen: bool = false) -> void:
	dialogLayer.init(dialog, showFullscreen)
	dialogLayer.visible = true


func _on_dialog_layer_dialog_completed() -> void:
	dialogLayer.visible = false
	dialogCompleted.emit()

	
func displayIngameHud() -> void:
	ingameLayer.visible = true

	
func hideIngameHud() -> void:
	ingameLayer.visible = false
	
	
func displayTutorial() -> void:
	GameManager.stopTimer()
	tutorialLayer.visible = true;


func hideTutorial() -> void:
	GameManager.startTimer()
	tutorialLayer.visible = false;


func _on_round_manager_update_progress_bar_to(score: float, maxScore: int) -> void:
	textureProgressBar.update(score, maxScore)
	
	
func _on_game_manager_update_the_final_countdown(timeArray: Array) -> void:
	timerLabel.update(timeArray)


func _on_dialog_layer_current_entity(entity: DialogOption.DIALOG_ENTITY) -> void:
	currentEntity.emit(entity)
