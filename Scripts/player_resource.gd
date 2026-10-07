class_name PlayerResource
extends Resource

@export var full_name: String
@export var skin_color: Player.Skin_Color
@export var role: Player.Role
@export var speed: float
@export var power: float

func _init(
	player_name: String,
	player_skin: Player.Skin_Color,
	player_role: Player.Role,
	player_speed: float = 0.0,
	player_power: float = 0.0
) -> void:
	full_name = player_name
	skin_color = player_skin
	role = player_role
	speed = player_speed
	power = player_power
