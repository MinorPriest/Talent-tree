extends Node

# --- Variables actuales (se mantienen) ---
var aviables_points: int = 0
var stamina_points: int = 1 
var power_points: int = 1 
var speed_points: int = 1 
var agility_points: int = 1 
var defense_points: int = 1 

# --- Nuevo: referencia al PlayerData actual ---
var player_database: Array[String] =[]
var current_file_index: int = 0
var current_player: PlayerData = null

# --- Señales (se mantienen) ---
signal aviables_points_changed(new_amount)
signal stamina_points_changed(new_amount)
signal power_points_changed(new_amount)
signal speed_points_changed(new_amount)
signal agility_points_changed(new_amount)
signal defense_points_changed(new_amount)
signal overall_changed(new_overall)
signal player_name_changed(new_name)

enum Stat { STAMINA, POWER, SPEED, AGILITY, DEFENSE }


func _ready():
	scan_players_folder()
	if not player_database.is_empty():
		load_player_by_index(0)
	else:
		push_error("No se encontraron archivos PlayerData en res://Resources/")
	
	
func scan_players_folder():
	var dir = DirAccess.open("res://Resources/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres") or file_name.ends_with(".res"):
				player_database.append("res://Resources/" + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("No se pudo abrir la carpeta Resources")
	
# --- Funciones existentes (sin cambios) ---
func get_skill_point(amount: int = 1):
	aviables_points += amount
	aviables_points_changed.emit(aviables_points)

func use_skill_point(stat: Stat, amount: int = 1) -> bool:
	if aviables_points < amount:
		return false

	match stat:
		Stat.STAMINA:
			if stamina_points + amount > 10: return false
			stamina_points += amount
			stamina_points_changed.emit(stamina_points)
		Stat.POWER:
			if power_points + amount > 10: return false
			power_points += amount
			power_points_changed.emit(power_points)
		Stat.SPEED:
			if speed_points + amount > 10: return false
			speed_points += amount
			speed_points_changed.emit(speed_points)
		Stat.AGILITY:
			if agility_points + amount > 10: return false
			agility_points += amount
			agility_points_changed.emit(agility_points)
		Stat.DEFENSE:
			if defense_points + amount > 10: return false
			defense_points += amount
			defense_points_changed.emit(defense_points)

	aviables_points -= amount
	aviables_points_changed.emit(aviables_points)
	_update_overall()
	return true

func remove_skill_point(stat: Stat, amount: int = 1) -> bool:
	match stat:
		Stat.STAMINA:
			if stamina_points - amount < 1: return false
		Stat.POWER:
			if power_points - amount < 1: return false
		Stat.SPEED:
			if speed_points - amount < 1: return false
		Stat.AGILITY:
			if agility_points - amount < 1: return false
		Stat.DEFENSE:
			if defense_points - amount < 1: return false

	match stat:
		Stat.STAMINA:
			stamina_points -= amount
			stamina_points_changed.emit(stamina_points)
		Stat.POWER:
			power_points -= amount
			power_points_changed.emit(power_points)
		Stat.SPEED:
			speed_points -= amount
			speed_points_changed.emit(speed_points)
		Stat.AGILITY:
			agility_points -= amount
			agility_points_changed.emit(agility_points)
		Stat.DEFENSE:
			defense_points -= amount
			defense_points_changed.emit(defense_points)

	aviables_points += amount
	aviables_points_changed.emit(aviables_points)
	_update_overall()
	return true

func has_skill_points(amount: int = 1) -> bool:
	return aviables_points >= amount

func get_stat_points(stat: Stat) -> int:
	var level: int
	match stat:
		Stat.STAMINA:   level = stamina_points
		Stat.POWER:     level = power_points
		Stat.SPEED:     level = speed_points
		Stat.AGILITY:   level = agility_points
		Stat.DEFENSE:   level = defense_points

	if level <= 4:
		return level * 5
	elif level <= 8:
		return 4 * 5 + (level - 4) * 10
	else:
		return 4 * 5 + 4 * 10 + (level - 8) * 20

func get_total_points() -> int:
	var total = 0
	for stat in Stat.values():
		total += get_stat_points(stat)
	return total

func get_overall() -> float:
	return get_total_points() / 5.0

func _update_overall():
	overall_changed.emit(get_overall())

# --- NUEVAS FUNCIONES para sincronizar con PlayerData ---
# Estas funciones NO se llaman automáticamente, solo cuando quieras guardar/cargar.

func save_to_player_data():
	"""Copia los valores actuales del SkillManager al PlayerData actual."""
	if current_player == null:
		push_error("No hay PlayerData asignado para guardar.")
		return
	
	current_player.stamina = stamina_points
	current_player.power = power_points
	current_player.speed = speed_points
	current_player.agility = agility_points
	current_player.defense = defense_points
	current_player.aviables_points = aviables_points

func load_from_player_data():
	"""Carga los valores del PlayerData actual al SkillManager."""
	if current_player == null:
		push_error("No hay PlayerData asignado para cargar.")
		return
	
	stamina_points = current_player.stamina
	power_points = current_player.power
	speed_points = current_player.speed
	agility_points = current_player.agility
	defense_points = current_player.defense
	aviables_points = current_player.aviables_points
	
	
	# Emitir señales para actualizar la UI
	aviables_points_changed.emit(aviables_points)
	player_name_changed.emit(current_player.player_name)
	stamina_points_changed.emit(stamina_points)
	power_points_changed.emit(power_points)
	speed_points_changed.emit(speed_points)
	agility_points_changed.emit(agility_points)
	defense_points_changed.emit(defense_points)
	_update_overall()

# --- Función para asignar un jugador (opcional) ---
func set_current_player(player: PlayerData):
	current_player = player
	# Si quieres que al cambiar se carguen sus datos, descomenta:
	# load_from_player_data()

func load_player_by_index(index: int):
	if index < 0 or index >= player_database.size():
		return
	current_file_index = index
	var path = player_database[index]
	var player = load(path)
	if player is PlayerData:
		current_player = player
		load_from_player_data()   # Esto carga las stats y emite señales
	else:
		push_error("El archivo no es un PlayerData válido: " + path)

func next_player():
	if player_database.is_empty():
		return
	var new_index = (current_file_index + 1) % player_database.size()
	load_player_by_index(new_index)

func previous_player():
	if player_database.is_empty():
		return
	var new_index = (current_file_index - 1 + player_database.size()) % player_database.size()
	load_player_by_index(new_index)
