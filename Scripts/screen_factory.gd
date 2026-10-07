class_name ScreenFactory

var screens : Dictionary

func _init() -> void:
	screens = {
		SoccerGame.ScreenType.IN_GAME: preload("res://Scenes/WorldScreen.tscn"),
		SoccerGame.ScreenType.MAIN_MENU: preload("res://Scenes/MainMenuScreen.tscn"),
		SoccerGame.ScreenType.TEAM_SELECTION: preload("res://Scenes/TeamScreenSelection.tscn"),
		SoccerGame.ScreenType.TOURNAMENT: preload("res://Scenes/TournamentScreen.tscn")
	}
func get_fresh_screen(screen: SoccerGame.ScreenType) -> Screen:
	assert(screens.has(screen), "screen does not exist! ")
	return screens.get(screen).instantiate()
