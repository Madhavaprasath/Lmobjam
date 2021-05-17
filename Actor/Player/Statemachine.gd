extends StateMachine

func _init():
	states={"Foot":{1:"Idle",
					2:"Run",
					3:"Jump",
					4:"Fall",
					5:"Dead"},
			"Crouch":{1:"Idle",
					2:"Run"}
	}
var mode="Foot"

func _ready():
	current_state=states[mode][1]

func state_logic(delta):
	parent.apply_movement(delta)
	parent.gravity_logic(delta)
	parent.velocity=parent.move_and_slide(parent.velocity)
func transition(delta):
	match current_state:
		"Idle":
			pass
		"Run":
			pass
		"Jump":
			pass
		"Fall":
			pass
	return null
func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		parent.velocity.y=parent.max_jump_velocity
	if event.is_action_released("ui_up") && parent.velocity.y > parent.min_jump_velocity:
		parent.velocity.y=parent.min_jump_velocity



func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass
