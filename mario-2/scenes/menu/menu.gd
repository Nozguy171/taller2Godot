extends MarginContainer

var is_open := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	visible = false
	is_open = false

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

func _on_start_pressed() -> void:
	print("papu:v")
	pass # Replace with function body.


func _on_finish_pressed() -> void:
	print("salir papu")
	get_tree().quit()


func _on_credits_pressed() -> void:
	pass # Replace with function body.
