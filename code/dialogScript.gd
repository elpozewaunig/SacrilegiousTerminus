extends CanvasLayer

signal dialogCompleted()

@export var pitch: float = 1.00
@export var pitch_range: float = 0.05
@export var type_speed: float = 1.2

@onready var dialogLabel: Label = $DialogLabel
@onready var audioplayer: AudioStreamPlayer = $TypewriterAudio
@onready var bus_index: int = AudioServer.get_bus_index("TypewriterPitcher")
@onready var effect: AudioEffect = AudioServer.get_bus_effect(bus_index, 0)

var dialogDone: bool = true;
var dialogPartDone: bool = true;
var dialogParts: Array[String] = []
var currentIndex: int = 0;
var visible_character: float = 0

func _ready() -> void:
	if dialogParts.size() > 0:
		resetDialogBox()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !dialogPartDone:
		write(delta)
	elif dialogDone:
		# emit the dialog completed signal
		dialogCompleted.emit()

func init(dialogArray: Array[String]) -> void:
	currentIndex = 0
	dialogParts = dialogArray
	resetDialogBox()

func resetDialogBox() -> void:
	dialogLabel.visible_ratio = 0
	dialogLabel.text = dialogParts[currentIndex]
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
		if audioplayer.stream != null and currentNotWhiteSpace():
			effect.pitch_scale = randf_range(pitch - pitch_range, pitch + pitch_range)
			audioplayer.play()

func currentNotWhiteSpace() -> bool:
	var regex = RegEx.new()
	regex.compile(r"\s")
	var currentVisibility = dialogLabel.text.length() * dialogLabel.visible_ratio - 1
	var result = regex.search(dialogLabel.text[currentVisibility])
	return result == null
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("skip-dialog"):
		if dialogPartDone:
			currentIndex += 1
			if currentIndex < dialogParts.size():
				# start next dialog
				resetDialogBox()
			else:
				# All dialog parts done
				dialogDone = true;
		else:
			# skip dialog
			dialogLabel.visible_ratio = 1;
