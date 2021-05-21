extends "res://Actor/enemies/Enemy.gd"

var exploded=false


signal dead
func attack_logic(delta):
	if player:
		direction=-sign(player.global_position.direction_to(global_position).x)
		var distance=player.global_position.distance_to(global_position)
		if distance>60 && !exploded:
			velocity.x=speed*direction*1.25
			$Body.scale.x=direction
		elif distance<60:
			velocity=Vector2()
			exploded=true
			dead=true
			emit_signal("dead")

func _on_destroy_area_body_entered(body):
	var direction_to_fall=body.global_position.direction_to(global_position)
	body.knocking=true
	body.knock_back_vector=-direction_to_fall
	
func _on_Arcade_machine_dead():
	animation_player.play("Explode")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["Explode"]:
		queue_free()


