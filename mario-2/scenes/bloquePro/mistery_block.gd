extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $AnimationTimer
const platano: PackedScene = preload("res://scenes/fruit/fruit.tscn")

var punched:bool = false
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("puchaste el block bro")
	if !punched:
		timer.start()
		punched = true
		var tween = get_tree().create_tween()
		tween.set_loops(1)
		tween.tween_property(sprite,"scale",Vector2(6.0,6.0),0.2)
		tween.tween_property(sprite,"scale",Vector2(3.0,3.0),0.2)
	else:
		print("ya me pegaste papu")


func _on_animation_timer_timeout() -> void:
	var fruit = platano.instantiate()
	fruit.position.y-=50
	fruit.scale.y=3.0
	fruit.scale.x=3.0
	add_child(fruit)
