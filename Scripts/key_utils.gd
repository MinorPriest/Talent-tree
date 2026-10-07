class_name KeyUtils

enum Action {LEFT, RIGHT, UP, DOWN, ACTION1, ACTION2, ACTION3}

const ACTION_MAP: Dictionary = {
	Player.ControlScheme.P1:{
		Action.LEFT: "p1_move_left",
		Action.RIGHT: "p1_move_right",
		Action.UP: "p1_move_up",
		Action.DOWN: "p1_move_down",
		Action.ACTION1: "p1_action1",
		Action.ACTION2: "p1_action2",
		Action.ACTION3: "p1_action3"
		},
	Player.ControlScheme.P2:{
		Action.LEFT: "p2_move_left",
		Action.RIGHT: "p2_move_right",
		Action.UP: "p2_move_up",
		Action.DOWN: "p2_move_down",
		Action.ACTION1: "p2_action1",
		Action.ACTION2: "p2_action2",
		Action.ACTION3: "p2_action3"
		}
	}

static func get_input_vector(scheme: Player.ControlScheme) -> Vector2:
	var map: Dictionary = ACTION_MAP[scheme]
	return Input.get_vector( map[Action.LEFT], map[Action.RIGHT], map[Action.UP], map[Action.DOWN])
	
static func is_action_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
	return Input.is_action_pressed(ACTION_MAP[scheme][action])
	
static func is_action_just_pressed(scheme: Player.ControlScheme, action: Action) -> bool:
	return Input.is_action_just_pressed(ACTION_MAP[scheme][action])
	
static func is_action_just_released(scheme: Player.ControlScheme, action: Action) -> bool:
	return Input.is_action_just_released(ACTION_MAP[scheme][action])
