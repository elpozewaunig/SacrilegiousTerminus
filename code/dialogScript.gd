extends CanvasLayer

@export var pitch: float = 1.00
@export var pitch_range: float = 0.05
@export var type_speed: float = 1.2

@onready var dialogLabel: Label = $DialogLabel
@onready var audioplayer: AudioStreamPlayer = $TypewriterAudio
@onready var bus_index: int = AudioServer.get_bus_index("TypewriterPitcher")
@onready var effect: AudioEffect = AudioServer.get_bus_effect(bus_index, 0)

var dialogDone: bool = true;
var dialogs = [
	"Me: The rift is opening and Satan is casting his will upon the world. But First i should go to the church and 
get rid of the Priest of this town. I don’t want any interferance when the new Lord assends to the earth.",
"Priester Robert: My good child, what brings you here today?",
"Me: I am here to help our Supremelord from the underworld Satan himself"
]
var currentIndex: int = 0;

func _ready() -> void:
	initDialogBox(dialogs[currentIndex])

# Called every frame. 'delta' is the elapsed time since the previous frame.
var visible_character: float = 0
func _process(delta: float) -> void:
	if !dialogDone:
		write(delta);

func initDialogBox(text: String) -> void:
	dialogLabel.visible_ratio = 0
	dialogLabel.text = text
	dialogDone = false

func write(delta: float) -> void:
	if dialogLabel.visible_ratio < 1:
		dialogLabel.visible_ratio += (type_speed * delta * 10) / dialogLabel.text.length()
	else: 
		dialogDone = true;
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


func reset() -> void:
	dialogLabel.visible_ratio = 0
	visible_character = 0
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("skip-dialog"):
		if dialogDone:
			currentIndex += 1
			if currentIndex < dialogs.size():
				initDialogBox(dialogs[currentIndex])
		else:
			dialogLabel.visible_ratio = 1;
