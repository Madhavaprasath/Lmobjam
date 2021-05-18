extends StateMachine

func _init():
	states={"Foot":{1:"Idle",
					2:"Run",
					3:"Jump",
					4:"Fall",
					5:"Shoot",
					6:"Wall_slide"},
			"Crouch":{1:"Idle",
					2:"Run"},
	}
var mode="Foot"

func _ready():
	current_state=states[mode][1]

func state_logic(delta):
	parent.apply_movement(delta)
	parent.gravity_logic_determine_jump(delta)
	parent.velocity=parent.move_and_slide(parent.velocity,Vector2.UP*32)
	check_mode()

func check_mode():
	if current_state in ["Fall"]:
		mode="Foot"

func transition(delta):
	match current_state:
		"Idle":
			if parent.is_on_floor():
				if parent.direction_x!=0:
					return states[mode][2]
			elif !parent.is_on_floor():
				if parent.velocity.y<0:
					return states["Foot"][3]
				if parent.velocity.y>0:
					return states["Foot"][4]
			elif parent.can_wall_jump:
				return states["Foot"][6]
			
		"Run":
			if parent.is_on_floor():
				if parent.direction_x==0:
					return states[mode][1]
			elif !parent.is_on_floor():
				if parent.velocity.y<0:
					return states["Foot"][3]
				if parent.velocity.y>0:
					return states["Foot"][4]
			elif parent.can_wall_jump:
				return states["Foot"][6]
		"Jump":
			if parent.velocity.y>0:
				return states["Foot"][4]
			elif parent.is_on_floor():
				return states["Foot"][1]
			elif parent.can_wall_jump:
				return states["Foot"][6]
		"Fall":
			if parent.is_on_floor():
				return states["Foot"][1]
			elif parent.can_wall_jump:
				return states["Foot"][6]
		"Wall_slide":
			if parent.is_on_floor():
				return states["Foot"][1]
	return null
func _unhandled_input(event):
	if current_state in ["Idle","Run"]:
		if mode=="Foot":
			parent.double_jumping=true if current_state in ["Jump","Fall"] else false
			if event.is_action_pressed("ui_up"):
				parent.velocity.y=parent.max_jump_velocity
				if parent.can_wall_jump:
					if parent.is_on_wall() && Input.is_action_pressed("ui_right"):
						parent.velocity.x=-parent.speed
					elif parent.is_on_wall() && Input.is_action_pressed("ui_left"):
						parent.velocity.x=parent.speed
			if event.is_action_released("ui_up") && parent.velocity.y > parent.min_jump_velocity:
				parent.velocity.y=parent.min_jump_velocity
		if event.is_action_pressed("ui_down"):
			mode="Crouch"
			print(mode)
		if event.is_action_released("ui_down"):
			mode="Foot"
			print(mode)


func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass
