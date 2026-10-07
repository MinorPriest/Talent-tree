extends Control

# --- Tus @onready (sin cambios) ---
@onready var aviables_points_label: Label = $BoxContainer2/HBoxContainer/VBoxContainer2/Aviables_points
@onready var player_name_label: Label = $BoxContainer2/HBoxContainer/VBoxContainer2/Name
@onready var stamina_points_label: Label = $BoxContainer3/VBoxContainer/TextureRect/StaminaSummary
@onready var power_points_label: Label = $BoxContainer3/VBoxContainer/TextureRect2/PowerSummary
@onready var speed_points_label: Label = $BoxContainer3/VBoxContainer/TextureRect3/SpeedSummary
@onready var agility_points_label: Label = $BoxContainer3/VBoxContainer/TextureRect4/AgilitySummary
@onready var defense_points_label: Label = $BoxContainer3/VBoxContainer/TextureRect5/DefenseSummary
@onready var overall_stats_label: Label = $BoxContainer2/HBoxContainer/VBoxContainer2/Overall



@onready var stamina_stars: HBoxContainer = $BoxContainer1/VBoxContainer/VBoxContainer2/VBoxContainer2/HBoxCont_Stamina
@onready var power_stars: HBoxContainer = $BoxContainer1/VBoxContainer/VBoxContainer2/VBoxContainer2/HBoxCont_Power
@onready var speed_stars: HBoxContainer = $BoxContainer1/VBoxContainer/VBoxContainer2/VBoxContainer2/HBoxCont_Speed
@onready var agility_stars: HBoxContainer = $BoxContainer1/VBoxContainer/VBoxContainer2/VBoxContainer2/HBoxCont_Agility
@onready var defense_stars: HBoxContainer = $BoxContainer1/VBoxContainer/VBoxContainer2/VBoxContainer2/HBoxCont_Defense

@onready var up_stamina_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer2/UpStamina/Button
@onready var down_stamina_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer2/DownStamina/Button
@onready var up_power_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer3/UpPower/Button
@onready var down_power_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer3/DownPower/Button
@onready var up_speed_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer4/UpSpeed/Button
@onready var down_speed_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer4/DownSpeed/Button
@onready var up_agility_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer5/UpAgility/Button
@onready var down_agility_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer5/DownAgility/Button
@onready var up_defense_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer6/UpDefense/Button
@onready var down_defense_btn: Button = $BoxContainer4/VBoxContainer/HBoxContainer6/DownDefense/Button
@onready var prev_btn: Button = $BoxContainer6/HBoxContainer6/Button
@onready var next_btn: Button = $BoxContainer6/HBoxContainer6/Button2
@onready var save_skill_btn: Button = $BoxContainer5/Button

func _ready():
	# Conectar señales (sin cambios)
	SkillManager.aviables_points_changed.connect(_on_aviables_points_changed)
	SkillManager.stamina_points_changed.connect(_on_stamina_points_changed)
	SkillManager.power_points_changed.connect(_on_power_points_changed)
	SkillManager.speed_points_changed.connect(_on_speed_points_changed)
	SkillManager.agility_points_changed.connect(_on_agility_points_changed)
	SkillManager.defense_points_changed.connect(_on_defense_points_changed)
	SkillManager.overall_changed.connect(_on_overall_changed)
	SkillManager.player_name_changed.connect(_on_player_name_changed)  
	prev_btn.pressed.connect(_on_previous_pressed)
	next_btn.pressed.connect(_on_next_pressed)
	save_skill_btn.pressed.connect(_on_save_pressed)
	
	# Actualizar UI inicial
	_on_aviables_points_changed(SkillManager.aviables_points)
	_on_stamina_points_changed(SkillManager.stamina_points)
	_on_power_points_changed(SkillManager.power_points)
	_on_speed_points_changed(SkillManager.speed_points)
	_on_agility_points_changed(SkillManager.agility_points)
	_on_defense_points_changed(SkillManager.defense_points)
	_on_overall_changed(SkillManager.get_overall())
	_on_player_name_changed(SkillManager.current_player.player_name)
	
	# Conectar botones (sin cambios)
	up_stamina_btn.pressed.connect(_on_up_pressed.bind(SkillManager.Stat.STAMINA))
	up_power_btn.pressed.connect(_on_up_pressed.bind(SkillManager.Stat.POWER))
	up_speed_btn.pressed.connect(_on_up_pressed.bind(SkillManager.Stat.SPEED))
	up_agility_btn.pressed.connect(_on_up_pressed.bind(SkillManager.Stat.AGILITY))
	up_defense_btn.pressed.connect(_on_up_pressed.bind(SkillManager.Stat.DEFENSE))
	
	down_stamina_btn.pressed.connect(_on_down_pressed.bind(SkillManager.Stat.STAMINA))
	down_power_btn.pressed.connect(_on_down_pressed.bind(SkillManager.Stat.POWER))
	down_speed_btn.pressed.connect(_on_down_pressed.bind(SkillManager.Stat.SPEED))
	down_agility_btn.pressed.connect(_on_down_pressed.bind(SkillManager.Stat.AGILITY))
	down_defense_btn.pressed.connect(_on_down_pressed.bind(SkillManager.Stat.DEFENSE))
	


# --- Funciones de actualización (sin cambios) ---
func _on_aviables_points_changed(amount: int):
	aviables_points_label.text = "Aviables Points: " + str(amount)

func _on_stamina_points_changed(amount: int):
	stamina_points_label.text = str(amount) + " / 10"
	_update_stars(stamina_stars, amount)

func _on_power_points_changed(amount: int):
	power_points_label.text = str(amount) + " / 10"
	_update_stars(power_stars, amount)

func _on_speed_points_changed(amount: int):
	speed_points_label.text = str(amount) + " / 10"
	_update_stars(speed_stars, amount)

func _on_agility_points_changed(amount: int):
	agility_points_label.text = str(amount) + " / 10"
	_update_stars(agility_stars, amount)

func _on_defense_points_changed(amount: int):
	defense_points_label.text = str(amount) + " / 10"
	_update_stars(defense_stars, amount)

func _update_stars(container: HBoxContainer, amount: int):
	var child_count = container.get_child_count()
	amount = clamp(amount, 0, child_count)
	for i in range(child_count):
		container.get_child(i).visible = i < amount

func _on_overall_changed(value: float):
	overall_stats_label.text = "Overall: " + str(value)

func _on_player_name_changed(new_name: String):
	player_name_label.text = new_name   

# --- Manejadores de botones (sin cambios) ---
func _on_up_pressed(stat: SkillManager.Stat):
	SkillManager.use_skill_point(stat, 1)

func _on_down_pressed(stat: SkillManager.Stat):
	SkillManager.remove_skill_point(stat, 1)

# --- Reset (sin cambios) ---
func _on_reset_pressed():
	SkillManager.reset_all_points()

func _on_previous_pressed():
	SkillManager.previous_player()

func _on_next_pressed():
	SkillManager.next_player()

func _on_save_pressed():
	if SkillManager.current_player == null:
		print("No hay jugador cargado para guardar.")
		return
	
	SkillManager.save_to_player_data()
	var path = SkillManager.player_database[SkillManager.current_file_index]
	var error = ResourceSaver.save(SkillManager.current_player, path)
	
	if error == OK:
		print("Jugador guardado en: ", path)
	else:
		print("Error al guardar: ", error)
