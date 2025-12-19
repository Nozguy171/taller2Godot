extends CharacterBody2D

enum PLAYER_STATES {IDLE, JUMP, RUN, FALL, HURT}
const MOVEMENT_SPEED: float = 160.0
const JUMP_SPEED: float = -450.0
const GRAVITY: float = 1000.0
const MAX_FALL_SPEED: float = GRAVITY * 3

var current_state: PLAYER_STATES = PLAYER_STATES.IDLE
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL_SPEED)
	get_input(delta)
	calculate_state()
	move_and_slide()
	
func get_input(delta: float):
	velocity.x = 0 
	#region Movimiento Lateral
	if(Input.is_action_pressed("move_left")):
		velocity.x = -MOVEMENT_SPEED
		sprite.flip_h = true
	elif(Input.is_action_pressed("move_right")):
		velocity.x = MOVEMENT_SPEED
		sprite.flip_h = false 
	#endregion
	
	#region Salto
	if(Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = JUMP_SPEED
	#endregion

func calculate_state(): 
	if is_on_floor():
		if(velocity.x == 0): 
			set_state(PLAYER_STATES.IDLE)
		else: 
			set_state(PLAYER_STATES.RUN)
	else:
		if(velocity.y < 0): 
			set_state(PLAYER_STATES.JUMP)
		else: 
			set_state(PLAYER_STATES.FALL)

func set_state(new_state: PLAYER_STATES):
	if(current_state != new_state):
		current_state = new_state 
		match current_state:
			PLAYER_STATES.IDLE: 
				anim_player.play("idle")
				print("Quieto")
			PLAYER_STATES.RUN:
				anim_player.play("run")
				print("Corriendo")
			PLAYER_STATES.JUMP:
				anim_player.play("jump")
				print("Salto")
			PLAYER_STATES.FALL:
				anim_player.play("fall")
				print("Cayendo")
	else:
		return
	
	
	
