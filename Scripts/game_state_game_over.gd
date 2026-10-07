class_name GameStateGameOver
extends GameState

@export var music: MusicPlayer.Music

func _enter_tree() -> void:
	var country_winner := GameManager.get_winner_country()
	GameEvents.game_over.emit(country_winner)
	
