extends MarginContainer

var main_level_scene = preload("res://scenes/main_level/main_level.tscn")

func _on_start_button_pressed() -> void:
	print("Start button pressed")
	get_tree().change_scene_to_packed(main_level_scene)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
