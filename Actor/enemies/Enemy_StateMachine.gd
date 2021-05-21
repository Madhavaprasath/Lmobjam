extends StateMachine


func _init():
	states=["Wander","Attack","Dead"]

func _ready():
	current_state=states[0]

func state_logic(delta):
	match current_state:
		"Idle":
			parent.velocity.x=lerp(parent.velocity.x,0,parent.Weight)
		"Wander":
			parent.wander_logic(delta)
		"Detect":
			pass
		"Attack":
			parent.attack_logic(delta)
	animate()
	if !parent.dead:
		parent.flip_character()
		parent.check_floor()
		check_attack_logic()
		parent.gravity_logic(delta)
		parent.velocity=parent.move_and_slide(parent.velocity,Vector2.UP*32)

func animate():
	if parent.velocity.x!=0 && current_state!="Attack":
		parent.animation_player.play("Wander")

func check_attack_logic():
	if parent.player!=null:
		current_state=states[1]
		previous_state="Attack"
	elif parent.player==null and previous_state=="Attack":
		current_state=parent.choose(['Wander'])
		previous_state=current_state

func _on_Timer_timeout():
	if current_state!="Attack":
		parent.timer.wait_time=parent.choose([0.5,0.75,1])
		current_state=parent.choose(["Wander"])

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass


