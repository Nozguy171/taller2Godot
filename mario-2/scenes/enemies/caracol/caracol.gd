extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_detection: RayCast2D = $FloorDetection
@onready var wall_detection: RayCast2D= $WallDetection
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const GRAVITY: float = 1000.0
const MOVEMENT_SPEED: float = 20.0

enum FACING_DIRECTION {
	LEFT = -1,
	RIGHT = 1,
}

var facing: FACING_DIRECTION= FACING_DIRECTION.LEFT
func _ready():
	pass
	
func _process(delta ):
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.x = MOVEMENT_SPEED * facing
		if wall_detection.is_colliding() or !floor_detection.is_colliding():
			flip_snail()
			
func flip_snail():
	if facing == FACING_DIRECTION.LEFT:
		facing = FACING_DIRECTION.RIGHT
	else:
		facing = FACING_DIRECTION.LEFT
	
	wall_detection.target_position.x *= -1
	floor_detection.position.x = floor_detection.position.x * -1
	anim_sprite.flip_h=!anim_sprite.flip_h


func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
