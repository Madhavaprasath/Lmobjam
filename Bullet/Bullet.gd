extends Area2D

class_name Bullet

export (int) var damage
export (int) var knock_factor=1
export (int) var speed=500
var direction=1

func _physics_process(delta):
	position.x+=direction*speed*delta

func start(Direction):
	scale.x=Direction
	direction=Direction
func _on_Bullet_body_entered(body):
	queue_free()


func _on_Self_Timer_timeout():
	queue_free()
