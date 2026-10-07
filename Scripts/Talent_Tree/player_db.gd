# PlayerData.gd
class_name PlayerData
extends Resource

# Atributos del jugador
@export var player_id: int = 000
@export var player_name: String = "Player"
@export var aviables_points: int = 0
@export var stamina: int = 1
@export var power: int = 1
@export var speed: int = 1
@export var agility: int = 1
@export var defense: int = 1
@export var goals: int = 0
@export var assists: int = 0
@export var wins: int = 0
@export var losses: int = 0

func get_total_points() -> int:
	var total = 0
	var stats = [stamina, power, speed, agility, defense]
	for level in stats:
		if level <= 4:
			total += level * 5
		elif level <= 8:
			total += 4 * 5 + (level - 4) * 10
		else:
			total += 4 * 5 + 4 * 10 + (level - 8) * 20
	return total

func get_overall() -> float:
	return get_total_points() / 5.0
