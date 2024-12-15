extends Control

signal dialogCompleted()
signal currentEntity(entity: DialogOption.DIALOG_ENTITY)

@onready var dialogLayer: CanvasLayer = $"%DialogLayer"
@onready var ingameLayer: CanvasLayer = $"%IngameLayer"
@onready var tutorialLayer: CanvasLayer = $"%TutorialLayer"
@onready var pauseMenuLayer: CanvasLayer = $"%PauseMenuLayer"

@onready var textureProgressBar: TextureProgressBar = $"%FightProgressBar"
@onready var timerLabel: Label = $"%TimerLabel"

func showDialog(dialog: Array[DialogOption], showFullscreen: bool = false) -> void:
	dialogLayer.init(dialog, showFullscreen)
	dialogLayer.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		displayPauseMenu()
	
func _process(_delta: float) -> void:
	timerLabel.update(GameManager.getTimerSignal())

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
	displayIngameHud();
	

func displayPauseMenu() -> void:
	if tutorialLayer.visible or dialogLayer.visible:
		return;
		
	GameManager.stopTimer()
	pauseMenuLayer.visible = true;


func hidePauseMenu() -> void:
	GameManager.startTimer()
	pauseMenuLayer.visible = false;

func _on_round_manager_update_progress_bar_to(score: float, maxScore: int) -> void:
	textureProgressBar.update(score, maxScore)


func _on_dialog_layer_current_entity(entity: DialogOption.DIALOG_ENTITY) -> void:
	currentEntity.emit(entity)


func _on_pause_menu_layer_resume_game() -> void:
	hidePauseMenu();
	displayIngameHud();
	

func _on_pause_menu_layer_return_to_menu() -> void:
	SceneManager.change_scene(SceneManager.mainMenuSene)


func _on_pause_menu_layer_show_tutorial() -> void:
	hidePauseMenu()
	displayTutorial()
