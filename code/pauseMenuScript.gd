extends CanvasLayer

signal showTutorial()
signal resumeGame()
signal returnToMenu()

@onready var resumeBtn: Button = $DialogContainer/DialogBox/VBoxContainer/ResumeBtn
@onready var tutorialBtn: Button = $DialogContainer/DialogBox/VBoxContainer/TutorialBtn
@onready var mainmenuBtn: Button = $DialogContainer/DialogBox/VBoxContainer/MainMenuBtn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resumeBtn.pressed.connect(self.resumeGame.emit)
	tutorialBtn.pressed.connect(self.showTutorial.emit)
	mainmenuBtn.pressed.connect(self.returnToMenu.emit)
