extends Control

signal dialogCompleted()

@export var player: Texture;
@export var enemy: Texture;
@export var background: Texture

@onready var hudOverlay: Control = $HudOverlay
@onready var playerSprite: Sprite2D = $CanvasLayer/PlayerSprite
@onready var enemySprite: Sprite2D = $CanvasLayer/EnemySprite
@onready var backgroundSprite: Sprite2D = $CanvasLayer/BackgroundSprite

var PLAYER_START_POSITION: Vector2 = Vector2(-650,1230)
var ENEMY_START_POSITION: Vector2 = Vector2(2500,1230)
var PLAYER_END_POSITION: Vector2 = Vector2(200,1230)
var ENEMY_END_POSITION: Vector2 = Vector2(1600,1230)

var currentSprite: Sprite2D;
var speed: float = 25.0 # Pixel pro Sekunde
var amplitude: float = 5.0
var time: float = 0.0
var start_y: float;

# Called when the node enters the scene tree for the first time.
func showDialog(dialogOptions: Array[DialogOption]) -> void:
	if playerSprite != null:
		playerSprite.position = PLAYER_START_POSITION
		playerSprite.texture = player;
	
	if enemySprite != null:
		enemySprite.position = ENEMY_START_POSITION
		enemySprite.texture = enemy;
		
	backgroundSprite.texture = background
	hudOverlay.showDialog(dialogOptions, false)
	
func _physics_process(delta: float) -> void:
	if !self.visible:
		return
	
	playerSprite.position = playerSprite.position.lerp(PLAYER_END_POSITION , 3 * delta)
	enemySprite.position = enemySprite.position.lerp(ENEMY_END_POSITION, 3 * delta)
	print("Enemy position: %s" % enemySprite.position.y)
	print("Enemy end position: %s" % ENEMY_END_POSITION.y)
	if currentSprite != null:
		# move sprite slightly up and down to mimic talking
		time += delta * speed
		currentSprite.position.y = start_y + sin(time) * amplitude
		

func _on_hud_overlay_current_entity(entity: DialogOption.DIALOG_ENTITY) -> void:
	if currentSprite != null:
		currentSprite.position = PLAYER_END_POSITION if currentSprite == playerSprite else ENEMY_END_POSITION
	if entity == DialogOption.DIALOG_ENTITY.NARRATOR:
		currentSprite = null
		return
	currentSprite = playerSprite if entity == DialogOption.DIALOG_ENTITY.PLAYER else enemySprite
	start_y = currentSprite.position.y


func _on_hud_overlay_dialog_completed() -> void:
	if currentSprite != null:
		currentSprite.position = PLAYER_END_POSITION if currentSprite == playerSprite else ENEMY_END_POSITION
		currentSprite = null
	dialogCompleted.emit()

	
func setPlayerEndPosition(vector: Vector2) -> void:
	PLAYER_END_POSITION = vector 


func setEnemyEndPosition(vector: Vector2) -> void:
	ENEMY_END_POSITION = vector


func setPlayerStartPosition(vector: Vector2) -> void:
	PLAYER_START_POSITION = vector 


func setEnemyStartPosition(vector: Vector2) -> void:
	ENEMY_START_POSITION = vector 		
