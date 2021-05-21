extends StateMachine

func _init():
	states={"Foot":{1:"Idle",
					2:"Run",
					3:"Jump",
					4:"Fall",
					5:"Shoot",
					6:"Wall_slide",
					7:"Knock_back"},
			"Crouch":{1:"Idle",
					2:"Run"},
	}
var mode="Foot"

func _ready():
	current_state=states[mode][1]

func state_logic(delta):
	if mode=="Foot":
		parent.apply_movement(delta)
	else:
		parent.apply_crouch_movement(delta)
	if current_state in ["Knock_back"]:
		parent.knock_back(delta)
	parent.flip_character(current_state)
	parent.gravity_logic_determine_jump(delta)
	parent.velocity=parent.move_and_slide(parent.velocity,Vector2.UP*32)
	check_mode()

func check_mode():
	if current_state in ["Fall"]:
		mode="Foot"
	if current_state in ["Idle"]:
		parent.can_wall_jump=false
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
			if parent.knocking:
				return states["Foot"][7]
			if parent.shooting:
				return states["Foot"][5]
			
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
			if parent.knocking:
				return states["Foot"][7]
			if parent.shooting:
				return states["Foot"][5]
		"Jump":
			if parent.velocity.y>0:
				return states["Foot"][4]
			elif parent.is_on_floor():
				return states["Foot"][1]
			elif parent.can_wall_jump:
				return states["Foot"][6]
			if parent.knocking:
				return states["Foot"][7]
		"Fall":
			if parent.is_on_floor():
				return states["Foot"][1]
			elif parent.can_wall_jump:
				return states["Foot"][6]
		"Wall_slide":
			if parent.is_on_floor():
				return states["Foot"][1]
			elif !parent.can_wall_jump:
				return states["Foot"][4]
		"Knock_back":
			if !parent.knocking:
				return states["Foot"][1]
		"Shoot":
			if !parent.shooting:
				return states["Foot"][1]
	return null

func _unhandled_input(event):
	if current_state in ["Idle","Run"]:
		if mode=="Foot":
			if event.is_action_pressed("ui_up"):
				parent.velocity.y=parent.max_jump_velocity
				if parent.can_wall_jump:
					if parent.is_on_wall() && Input.is_action_pressed("ui_right"):
						parent.velocity.x=-parent.speed
					elif parent.is_on_wall() && Input.is_action_pressed("ui_left"):
						parent.velocity.x=parent.speed
			if event.is_action_released("ui_up") && parent.velocity.y > parent.min_jump_velocity:
				parent.velocity.y=parent.min_jump_velocity
		else:
			if event.is_action_pressed("ui_down"):
				mode="Crouch"
			if event.is_action_released("ui_down"):
				mode="Foot"
	if current_state in ["Idle"]:
		if event.is_action_pressed("Click") && !parent.shooting:
			Global.on_shooting(parent.bullet,parent.spawn_point.global_position,parent.facing)
			parent.shooting=true
			parent.reload_timer.start()


func enter_state(old_state,new_state):
	parent.animation_player.play(new_state)
	parent.play_sound(new_state)
func exit_state(old_state,new_state):
	pass
