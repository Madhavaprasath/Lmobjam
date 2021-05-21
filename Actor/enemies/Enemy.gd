extends Actor
class_name Enemy

var flying=false

#state_logic 
var player=null
var player_position=Vector2()


export (int) var direction=1
var wall_colliding=false
var floor_colliding=true
var dead=false

onready var timer=get_node("Timer")
onready var raycast=get_node("Body/Down_raycast")

func wander_logic(delta):
	velocity.x=direction*speed

func flip_character():
	if  detect_wall():
		direction*=-1
	$Body.scale.x=direction

func check_floor():
	if !flying:
		if is_on_floor()&& !raycast.is_colliding():
			direction*=-1
		$Body.scale.x=direction

func gravity_logic(delta):
	if !flying:
		velocity.y+=gravity*delta

func attack_logic(delta):
	velocity.x=lerp(velocity.x,0,Weight)

func detect_wall():
	for i in $Body/Wall_raycast.get_children():
		if i.is_colliding():
			return true
	return false



func knock_back(delta):
	pass


func _on_Detect_area_body_entered(body):
	player=body
	player_position=player.global_position

func _on_Detect_area_body_exited(body):
	player=null

func choose(array:Array):
	array.shuffle()
	return array.front()

