class_name PlayerStateDash
extends PlayerState

const RECOVERY_AFTER_DASH := 0 
const GROUND_FRICTION := 200.0
const DASH_SPEED_MULTIPLIER := 2.0
const DURATION_DASH := 300

var time_start_dash := Time.get_ticks_msec()
var time_finish_dash := 0
var is_dash_complete := false

func _enter_tree() -> void:
	animation_player.play("Dash")
	player.velocity = player.heading * player.speed * DASH_SPEED_MULTIPLIER
	time_start_dash = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	if not is_dash_complete:
		
		if Time.get_ticks_msec() - time_start_dash > DURATION_DASH:
			is_dash_complete = true
			time_finish_dash = Time.get_ticks_msec()
	elif Time.get_ticks_msec() - time_finish_dash > RECOVERY_AFTER_DASH:
		transition_state(Player.State.MOVING)
