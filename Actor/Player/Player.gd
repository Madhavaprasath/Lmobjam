extends Actor

#kinematics
var can_wall_jump
var double_jumping
var direction_x

func apply_movement(delta):
	var directions={"Left":Input.is_action_pressed("ui_left"),
					"Right":Input.is_action_pressed("ui_right")}
	direction_x=int(directions["Right"])-int(directions["Left"])
	velocity.x=lerp(velocity.x,direction_x*speed,Weight)

func apply_crouch_movement(delta):
	var directions={"Left":Input.is_action_pressed("ui_left"),
					"Right":Input.is_action_pressed("ui_right")}
	direction_x=int(directions["Right"])-int(directions["Left"])
	velocity.x=lerp(velocity.x,direction_x*crouch_speed,Weight)

func gravity_logic_determine_jump(delta):
	if is_on_wall() && (Input.is_action_pressed("ui_left")||Input.is_action_pressed("ui_right")):
		can_wall_jump=true
		if velocity.y>=0:
			velocity.y=min(velocity.y+20,100)
		else:
			velocity.y+=gravity*delta
	else:
		velocity.y+=gravity*delta



func attack_logic(delta):
	pass

func knock_back(delta):
	pass
