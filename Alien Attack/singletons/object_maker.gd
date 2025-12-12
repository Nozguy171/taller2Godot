extends Node

var player_bullet = preload("res://scenes/objects/player_bullet.tscn")

func create_player_bullet(angle:float, marker_pos:Vector2):
	var new_bullet = player_bullet.instantiate()
	new_bullet.global_position = marker_pos
	new_bullet.rotation = angle
	get_tree().get_current_scene().add_child(new_bullet)
