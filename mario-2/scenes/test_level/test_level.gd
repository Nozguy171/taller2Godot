extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Perdiste we te moriste")
	player.position.x=0
	player.position.y=0
	SignalManager.onPlayerDefeated.emit()

func _on_win_flag_area_entered(area: Area2D) -> void:
	print("Ganaste papupro")
	SoundsManager.play_sound(audio_player, SoundsManager.PLAYER_SOUND_LAND)
	SignalManager.onWin.emit()
