extends "res://Actor/enemies/Enemy.gd"

export (PackedScene) var bullet


onready var target_vector_x=Vector2(global_position.x+500,global_position.x-500)
onready var start_position=transform.get_origin().x




var can_shoot=false
func _ready():
	flying=true

func flip_character():
	if !player:
		if global_position.x>=target_vector_x.x||global_position.x<=target_vector_x.y:
			velocity=Vector2()
			direction*=-1
			velocity.x=direction*speed
		elif  detect_wall():
			direction*=-1
		$Body.scale.x=direction

func attack_logic(delta):
	if player:
		direction=-sign(player.global_position.direction_to(global_position).x)
		var distance=player.global_position.distance_to(global_position)
		if distance>110:
			velocity=150*(global_position.direction_to(player.global_position))
		elif distance<110:
			velocity=Vector2(0,(player.global_position.y-global_position.y)-10)
		if can_shoot:
			animation_player.play("Shoot")
			$Reload_timer.start(1)
			can_shoot=false
		body.scale.x=direction


func _on_Reload_timer_timeout():
	can_shoot=true

func shoot():
	Global.on_shooting(bullet,$Body/bullet_spawner.global_position,direction)


func _on_AnimationPlayer_animation_finished(anim_name):
	if !can_shoot:
		animation_player.play("Wander")


func _on_Shoot_area_body_entered(body):
	can_shoot=true


func _on_Shoot_area_body_exited(body):
	can_shoot=false
