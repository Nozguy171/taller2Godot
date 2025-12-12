extends CharacterBody2D

@onready var player: Player 

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta: float) -> void:
	look_at(player.global_position)
