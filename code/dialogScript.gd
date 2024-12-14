extends CanvasLayer

signal dialogCompleted()

@export var pitch: float = 1.00
@export var pitch_range: float = 0.05
@export var type_speed: float = 0.8

@onready var dialogLabel: Label = $DialogLabel
@onready var backgroundLabel: Label = $BackgroundLabel

# audio streams depending on entity
@onready var narratorAudioPlayer: AudioStreamPlayer = $NarratorAudio
@onready var playerVoiceAudioPlayer: AudioStreamPlayer = $PlayerVoiceAudio
@onready var enemyVoiceAudioPlayer: AudioStreamPlayer = $EnemyVoiceAudio

# audio pitcher
@onready var bus_index: int = AudioServer.get_bus_index("DialogPitcher")
@onready var effect: AudioEffect = AudioServer.get_bus_effect(bus_index, 0)

# internal variables
var dialogDone: bool = true;
var dialogPartDone: bool = true;
var dialogParts: Array[DialogOption] = []
var currentIndex: int = 0;
var visible_character: float = 0
var audioplayer: AudioStreamPlayer = null

func _ready() -> void:
	if dialogParts.size() > 0:
		resetDialogBox()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !dialogPartDone && !dialogDone:
		write(delta)
		

func init(dialogArray: Array[DialogOption], showFullscreen: bool = true) -> void:
	if showFullscreen:
		backgroundLabel.visible = true
		dialogLabel.set_anchors_preset(Control.PRESET_CENTER)
		dialogLabel.offset_left = 0
		dialogLabel.offset_right = 0
		dialogLabel.offset_bottom = 0
		dialogLabel.offset_top = 0
	else:
		backgroundLabel.visible = false
		dialogLabel.anchor_bottom = 0.99
		dialogLabel.anchor_left = 0.5
		dialogLabel.anchor_top = 0.99
		dialogLabel.anchor_right = 0.5
	
	currentIndex = 0
	dialogParts = dialogArray
	resetDialogBox()

func resetDialogBox() -> void:
	dialogLabel.visible_ratio = 0
	dialogLabel.text = dialogParts[currentIndex].text
	audioplayer = getAudioplayer()
	dialogLabel.visible_ratio = 0
	visible_character = 0
	dialogPartDone = false
	dialogDone = false

func write(delta: float) -> void:
	if dialogLabel.visible_ratio < 1:
		dialogLabel.visible_ratio += (type_speed * delta * 10) / dialogLabel.text.length()
	else: 
		dialogPartDone = true;
	if visible_character != dialogLabel.visible_characters:
		visible_character = dialogLabel.visible_characters
		if audioplayer != null and currentNotWhiteSpace():
			effect.pitch_scale = randf_range(pitch - pitch_range, pitch + pitch_range)
			audioplayer.play()

func getAudioplayer() -> AudioStreamPlayer:
	var audioplayer: AudioStreamPlayer = null;
	var entity: DialogOption.DIALOG_ENTITY = dialogParts[currentIndex].entity;
	match entity:
		DialogOption.DIALOG_ENTITY.PLAYER:
			audioplayer = playerVoiceAudioPlayer
		DialogOption.DIALOG_ENTITY.ENEMY:
			audioplayer = enemyVoiceAudioPlayer
		DialogOption.DIALOG_ENTITY.NARRATOR:
			audioplayer = narratorAudioPlayer
	return audioplayer

func currentNotWhiteSpace() -> bool:
	var regex = RegEx.new()
	regex.compile(r"\s")
	var currentVisibility = dialogLabel.text.length() * dialogLabel.visible_ratio - 1
	var result = regex.search(dialogLabel.text[currentVisibility])
	return result == null
	
	
func _input(event: InputEvent) -> void:
	if visible && Input.is_action_just_released("skip-dialog"):
		if dialogPartDone:
			currentIndex += 1
			if currentIndex < dialogParts.size():
				# start next dialog
				resetDialogBox()
			else:
				# All dialog parts done
				dialogDone = true;
				# emit the dialog completed signal
				dialogCompleted.emit()
		else:
			# skip dialog
			dialogLabel.visible_ratio = 1;
