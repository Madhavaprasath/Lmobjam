extends Actor

#kinematics
var jumping


func apply_movement(delta):
	var directions={"Left":Input.is_action_pressed("ui_left"),
					"Right":Input.is_action_pressed("ui_right")}
	var direction_x=int(directions["Right"])-int(directions["Left"])
	velocity.x=lerp(velocity.x,direction_x*speed,Weight)

func apply_crouch_movement(delta):
	var directions={"Left":Input.is_action_pressed("ui_left"),
					"Right":Input.is_action_pressed("ui_right")}
	var direction_x=int(directions["Right"])-int(directions["Left"])
	velocity.x=lerp(velocity.x,direction_x*crouch_speed,Weight)


func gravity_logic(delta):
	velocity.y+=gravity*delta


func attack_logic(delta):
	pass

func knock_back(delta):
	pass
