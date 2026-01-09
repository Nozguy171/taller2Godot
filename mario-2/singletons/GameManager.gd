extends Node

var lives: int = 3 
var score: int = 0 

func _ready() -> void:
	reset()
	SignalManager.on_hurt.connect(on_hurt_received)
	SignalManager.on_bonus_grabbed.connect(on_bonus_grabbed)

func reset() -> void:
	score = 0
	lives = 3
	SignalManager.on_score_changed.emit(score)
	SignalManager.on_lives_changed.emit(lives)

func on_hurt_received():
	lives -= 1 
	SignalManager.on_lives_changed.emit(lives)
	if lives <= 0:
		SignalManager.onPlayerDefeated.emit()

func on_bonus_grabbed(bonus_score: int):
	score += bonus_score
	SignalManager.on_score_changed.emit(score)
	
