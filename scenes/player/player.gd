extends CharacterBody2D

@export var movement_speed: float = 2000.0
@export var rotation_speed: float = 50.0

var _screen_size

func _ready():
	_screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	#region Character Rotation
	if(Input.is_action_pressed("rotate_left")):
		rotation_degrees -= rotation_speed * delta
	elif(Input.is_action_pressed("rotate_right")):
		rotation_degrees += rotation_speed * delta
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
