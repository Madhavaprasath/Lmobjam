extends Node


signal on_entity_shooting(bullet,_position,direction)

func on_shooting(bullet,_position,direction):
	emit_signal("on_entity_shooting",bullet,_position,direction)

