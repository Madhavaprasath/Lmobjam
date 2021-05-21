extends Actor

export (PackedScene) var bullet


var knocking=false
var wall_slide_impulse=speed*2

var shooting=false


#kinematics
var can_wall_jump
var double_jumping
var direction_x
var facing=1

onready var reload_timer=get_node("Timer")
onready var spawn_point=get_node("Body/Position2D")

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
			can_wall_jump=false
			velocity.y+=gravity*delta
	else:
		velocity.y+=gravity*delta

func flip_character(state):
	var direction=int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	if direction!=0:
		var temp=direction if state !="Wall_slide" else -direction
		facing=temp
		body.scale.x=temp


func attack_logic(delta):
	pass

func knock_back(delta):
	velocity=knock_back_vector*500
	yield(get_tree().create_timer(0.25),"timeout")
	velocity=Vector2()
	knocking=false


func _on_Timer_timeout():
	shooting=false
