extends MarginContainer
var main_level_scene = preload("res://scenes/test_level/test_level.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_level_scene)
	print("papu:v")
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	print("salir papu")
	get_tree().quit()
	pass # Replace with function body.
