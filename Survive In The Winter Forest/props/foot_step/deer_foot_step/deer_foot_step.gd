extends Node2D


func _ready():
	#start_foot_step()
	pass

func start_foot_step():
	$Timer.set_wait_time(1)
	$Timer.start()


func _on_Timer_timeout():
	$AnimationPlayer.play("play")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "play":
		queue_free()
