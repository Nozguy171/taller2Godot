extends CharacterBody2D

class_name Player

@export var movement_speed: float = 2000.0
@export var rotation_speed: float = 50.0

var _screen_size
var can_shoot = true 
var cnt = 0 
@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_marker: Marker2D = $Marker2D
func _ready():
	_screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	#region Character Rotation
	if(Input.is_action_pressed("rotate_left")):
		rotation_degrees -= rotation_speed * delta
	elif(Input.is_action_pressed("rotate_right")):
		rotation_degrees += rotation_speed * delta
	#endregion
	
	#region Character Shooting
	if(Input.is_action_just_pressed("shoot") and can_shoot):
		ObjectMaker.create_player_bullet(rotation, shoot_marker.global_position)
		can_shoot = false
		shoot_timer.start()
	#endregion
	
func _physics_process(delta: float) -> void:
	#region Character Movement
	if(Input.is_action_pressed("move_up")):
		velocity.y = -movement_speed * delta
	elif(Input.is_action_pressed("move_down")):
		velocity.y = movement_speed * delta
	if(Input.is_action_pressed("move_left")):
		velocity.x = -movement_speed * delta
	elif(Input.is_action_pressed("move_right")):
		velocity.x = movement_speed * delta
	#endregion
	
	position.x = clampf(position.x, 0, _screen_size.x)
	position.y = clampf(position.y, 0, _screen_size.y)
	move_and_slide()
	reset_movement()
	
func reset_movement():
	velocity.y = 0 
	velocity.x = 0 

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
