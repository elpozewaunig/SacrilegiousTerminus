extends Control

signal dialogCompleted()
signal currentEntity(entity: DialogOption.DIALOG_ENTITY)

@onready var dialogLayer: CanvasLayer = $"%DialogLayer"
@onready var ingameLayer: CanvasLayer = $"%IngameLayer"
@onready var tutorialLayer: CanvasLayer = $"%TutorialLayer"
@onready var pauseMenuLayer: CanvasLayer = $"%PauseMenuLayer"

@onready var textureProgressBar: TextureProgressBar = $"%FightProgressBar"
@onready var timerLabel: Label = $"%TimerLabel"

@onready var gotItBtn: Button = $"%GotItBtn"
@onready var resumeBtn: Button = $"%ResumeBtn"

func showDialog(dialog: Array[DialogOption], showFullscreen: bool = false) -> void:
	dialogLayer.init(dialog, showFullscreen)
	dialogLayer.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		if not pauseMenuLayer.visible:
			displayPauseMenu()
		else:
			hidePauseMenu()
	
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
	tutorialLayer.visible = true;
	get_tree().paused = true


func hideTutorial() -> void:
	tutorialLayer.visible = false;
	get_tree().paused = false
	

func displayPauseMenu() -> void:
	if tutorialLayer.visible or dialogLayer.visible:
		return;
		
	pauseMenuLayer.visible = true;
	resumeBtn.grab_focus()
	get_tree().paused = true


func hidePauseMenu() -> void:
	pauseMenuLayer.visible = false;
	get_tree().paused = false

func _on_round_manager_update_progress_bar_to(score: float, maxScore: int) -> void:
	textureProgressBar.update(score, maxScore)


func _on_dialog_layer_current_entity(entity: DialogOption.DIALOG_ENTITY) -> void:
	currentEntity.emit(entity)


func _on_pause_menu_layer_resume_game() -> void:
	hidePauseMenu();
	

func _on_pause_menu_layer_return_to_menu() -> void:
	get_tree().paused = false
	SceneManager.change_scene(SceneManager.mainMenuSene)


func _on_pause_menu_layer_show_tutorial() -> void:
	hidePauseMenu()
	displayTutorial()
	gotItBtn.grab_focus()
