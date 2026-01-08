extends Camera2D

@export var player: Player
@onready var shake_timer: Timer = $Timer
const SHAKE_AMOUNT: float = 10.0
const SHAKE_TIME: float = 0.7
var is_shaking: bool

func _ready() -> void:
	SignalManager.on_hurt.connect(start_shaking)
	is_shaking = false 

func _process(delta: float) -> void:
	position = player.position
	if is_shaking: 
		offset = Vector2(
			randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT),
			randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT)
		)

func start_shaking():
	is_shaking = true
	shake_timer.start(SHAKE_TIME)

func _on_timer_timeout() -> void:
	is_shaking = false
	offset = Vector2.ZERO #Vector2(0,0)
