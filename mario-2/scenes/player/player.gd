extends CharacterBody2D

class_name Player

enum PLAYER_STATES {IDLE, JUMP, RUN, FALL, HURT}
const MOVEMENT_SPEED: float = 160.0
const JUMP_SPEED: float = -450.0
const GRAVITY: float = 1000.0
const MAX_FALL_SPEED: float = GRAVITY * 3
const HURT_JUMP_SPEED: float = -100.0

var current_state: PLAYER_STATES = PLAYER_STATES.IDLE
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var jump_hitbox_collision = $JumpHitbox/CollisionShape2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if current_state != PLAYER_STATES.HURT: 
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
		if current_state == PLAYER_STATES.FALL and (new_state == PLAYER_STATES.IDLE or new_state == PLAYER_STATES.RUN):
			SoundsManager.play_sound(audio_player, SoundsManager.PLAYER_SOUND_LAND)
			jump_hitbox_collision.disabled = true
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
				SoundsManager.play_sound(audio_player, SoundsManager.PLAYER_SOUND_JUMP)
				print("Salto")
			PLAYER_STATES.FALL:
				anim_player.play("fall")
				jump_hitbox_collision.disabled = false
				print("Cayendo")
			PLAYER_STATES.HURT:
				anim_player.play("hurt")
				SoundsManager.play_sound(audio_player, SoundsManager.PLAYER_SOUND_HURT)
				print("Con dano")
	else:
		return
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	apply_hit()
	SignalManager.on_hurt.emit()
	
func apply_hit(): 
	velocity.x = 0 
	velocity.y = HURT_JUMP_SPEED
	set_state(PLAYER_STATES.HURT)
	invincible_timer.start()
	var tween = get_tree().create_tween()
	tween.set_loops(1)
	tween.tween_property(sprite, "self_modulate",Color(1,0,0,0.5),0.5)
	tween.tween_property(sprite, "self_modulate",Color(1,1,1,1),0.5)

func _on_invincible_timeout() -> void:
	print("Control recuperado")
	set_state(PLAYER_STATES.IDLE)
	velocity.y = 0

func _on_jump_hitbox_area_entered(area: Area2D) -> void:
	velocity.y = HURT_JUMP_SPEED * 5
