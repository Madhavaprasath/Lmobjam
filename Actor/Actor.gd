 extends KinematicBody2D
class_name Actor

#constants
const Weight=0.4

#export variables
export (int) var speed=400
export (int) var crouch_speed=100

#kinematics
var velocity=Vector2()
var max_jump_speed=3*32
var min_jump_speed=2*32
var jump_duration=0.4
onready var gravity=(2*max_jump_speed)/pow(jump_duration,2)
onready var max_jump_velocity=-sqrt(2*gravity*max_jump_speed)
onready var min_jump_velocity=-sqrt(2*gravity*min_jump_speed)



func apply_movement(delta):
	pass

func gravity_logic(delta):
	pass

func attack_logic(delta):
	pass

func knock_back(delta):
	pass
