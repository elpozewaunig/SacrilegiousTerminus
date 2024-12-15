extends Control

signal dialogCompleted()
signal currentEntity(entity: DialogOption.DIALOG_ENTITY)
signal tutorialVisibilityChanged(closed: bool)

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
	tutorialLayer.visible = true;
	tutorialVisibilityChanged.emit(!tutorialLayer.visible)


func hideTutorial() -> void:
	tutorialLayer.visible = false;
	tutorialVisibilityChanged.emit(!tutorialLayer.visible)


func _on_round_manager_update_progress_bar_to(score: float, maxScore: int) -> void:
	textureProgressBar.update(score, maxScore)
	
	
func _on_game_manager_update_the_final_countdown(timeArray: Array) -> void:
	timerLabel.update(timeArray)


func _on_dialog_layer_current_entity(entity: DialogOption.DIALOG_ENTITY) -> void:
	currentEntity.emit(entity)
