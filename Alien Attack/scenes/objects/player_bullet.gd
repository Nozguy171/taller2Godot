extends Area2D

class_name PlayerBullet
var bullet_speed: float = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.y * delta * bullet_speed

func on_bullet_exited() -> void:
	queue_free()
