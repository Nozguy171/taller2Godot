extends Node2D

var menuLevelScene = preload("res://scenes/menu/menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_open_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _open_menu() -> void:
	visible = true
	get_tree().paused = true

func _close_menu() -> void:
	visible = false
	get_tree().paused = false


func _on_texture_button_pressed() -> void:
	_close_menu()
