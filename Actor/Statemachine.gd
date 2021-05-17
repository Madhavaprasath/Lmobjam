extends Node
class_name StateMachine

var states={}

var current_state
var previous_state
onready var parent=get_parent()

func _ready():
	pass

func _physics_process(delta):
	state_logic(delta)
	var transition=transition(delta)
	if transition!=null:
		previous_state=current_state
		current_state=transition
		enter_state(previous_state,current_state)
		exit_state(previous_state,current_state)

func state_logic(delta):
	pass

func transition(delta):
	return null

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass
