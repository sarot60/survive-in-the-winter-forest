extends Particles2D


func _ready():
	
	$show_blood_timer.set_wait_time(0.5)
	$show_blood_timer.start()

func _on_show_blood_timer_timeout():
	
	$blood.show()
	
	$queue_free_timer.set_wait_time(5)
	$queue_free_timer.start()
	


func _on_queue_free_timer_timeout():
	queue_free()
