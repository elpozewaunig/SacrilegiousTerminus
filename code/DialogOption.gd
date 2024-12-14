extends Resource
class_name DialogOption

enum DIALOG_ENTITY {PLAYER, ENEMY, NARRATOR}
@export var entity: DIALOG_ENTITY
@export var text: String

func _init(_entity: DIALOG_ENTITY, _text: String) -> void:
	entity = _entity
	text = _text
	
