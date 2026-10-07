extends Node


enum Sound {BOUNCE, HURT, PASS, POWERSHOT, SHOT, TACKLING, UI_NAVIGATE, UI_SELECTION, WHISTLE}

const NB_CHANNELS = 4
const SFX_MAP: Dictionary[Sound, AudioStream] = {
	Sound.BOUNCE: preload("res://Assets/Character/assets/sfx/bounce.wav"),
	Sound.HURT: preload("res://Assets/Character/assets/sfx/hurt.wav"),
	Sound.PASS: preload("res://Assets/Character/assets/sfx/pass.wav"),
	Sound.POWERSHOT: preload("res://Assets/Character/assets/sfx/power-shot.wav"),
	Sound.SHOT: preload("res://Assets/Character/assets/sfx/shoot.wav"),
	Sound.TACKLING: preload("res://Assets/Character/assets/sfx/tackle.wav"),
	Sound.UI_NAVIGATE: preload("res://Assets/Character/assets/sfx/ui-navigate.wav"),
	Sound.UI_SELECTION: preload("res://Assets/Character/assets/sfx/ui-select.wav"),
	Sound.WHISTLE: preload("res://Assets/Character/assets/sfx/whistle.wav"),
}

var stream_players: Array[AudioStreamPlayer] = []

func _ready() -> void:
	for i in range(NB_CHANNELS):
		var stream_player := AudioStreamPlayer.new()
		stream_players.append(stream_player)
		add_child(stream_player)

func play(sound: Sound) -> void:
	var stream_player := find_first_aviable_player()
	if stream_player != null:
		stream_player.stream = SFX_MAP[sound]
		stream_player.play()

func find_first_aviable_player() -> AudioStreamPlayer:
	for stream_player in stream_players:
		if not stream_player.playing:
			return stream_player
	return null
			
