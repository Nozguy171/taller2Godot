extends CharacterBody2D

@onready var player: Player 

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta: float) -> void:
	look_at(player.global_position)

func _on_damage_received(area: Area2D) -> void:
	print("Damaged!")
	queue_free()
