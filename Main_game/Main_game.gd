extends Node2D

func _ready():
	Global.connect("on_entity_shooting",self,"on_shooting")
	
	

func on_shooting(bullet,_position,direction):
	var bullet_child=bullet.instance()
	bullet_child.position=_position
	bullet_child.start(direction)
	add_child(bullet_child)
