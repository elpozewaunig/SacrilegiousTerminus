extends Node
class_name TouchInputHandler


@export var swipe_threshold: float = 50
@export var touch_threshold: float = 10

var _is_screen_pressed: bool = false
var _touch_start_pos: Vector2
var _touch_end_pos: Vector2

var _swipe_handled: bool = false
var _press_handled: bool = true

var screen_just_pressed: bool = false
var swiped_right: bool = false
var swiped_left: bool = false
var swiped_down: bool = false
var swiped_up: bool = false


func _process(_delta: float) -> void:
	_reset_touch_detections()
	var swipe: Vector2 = _touch_end_pos - _touch_start_pos
	
	if not _swipe_handled and _is_screen_pressed:
		if swipe.length() >= swipe_threshold:
			# Swipe has been detected
			_swipe_handled = true
			
			if abs(swipe.x) >= abs(swipe.y):
				if swipe.x > 0:
					set_deferred("swiped_right", true)
				else:
					set_deferred("swiped_left", true)
			else:
				if swipe.y > 0:
					set_deferred("swiped_down", true)
				else:
					set_deferred("swiped_up", true)
		
	if not _press_handled and not _is_screen_pressed:
		if swipe.length() <= touch_threshold:
			# Finger moved very little, interpret as touch event
			set_deferred("screen_just_pressed", true)
			_press_handled = true

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		_touch_end_pos = event.position
	
	elif event is InputEventScreenTouch:
		if event.is_pressed():
			if not _is_screen_pressed:
				# Just pressed, allow swipe check
				_touch_start_pos = event.position
				_touch_end_pos = event.position
				_swipe_handled = false
			_is_screen_pressed = true
		
		else:
			if _is_screen_pressed:
				# Just released, allow press check
				_press_handled = false
			_is_screen_pressed = false

func _reset_touch_detections() -> void:
	set_deferred("screen_just_pressed", false)
	set_deferred("swiped_right", false)
	set_deferred("swiped_left", false)
	set_deferred("swiped_down", false)
	set_deferred("swiped_up", false)
