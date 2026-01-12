extends MarginContainer
var main_level_scene = preload("res://scenes/test_level/test_level.tscn")
var credits_scene = preload("res://scenes/credits/credits.tscn")
var is_open := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	visible = false
	is_open = false
	_open_menu()
	# Escuchar señales
	SignalManager.onPlayerDefeated.connect(_open_menu)
	SignalManager.onWin.connect(_open_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_open:
			_close_menu()
		else:
			_open_menu()

func _open_menu() -> void:
	is_open = true
	visible = true
	get_tree().paused = true

func _close_menu() -> void:
	is_open = false
	visible = false
	get_tree().paused = false


func _on_start_button_pressed() -> void:
	_close_menu()
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_packed(credits_scene)
	pass # Replace with function body.
