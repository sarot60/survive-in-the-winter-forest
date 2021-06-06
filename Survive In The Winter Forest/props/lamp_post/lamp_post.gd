extends StaticBody2D



func _on_light_timer_timeout():
	$Tween.interpolate_property($Light2D, "energy",
	$Light2D.energy, rand_range(0.5,0.8), 0.15,
	$Tween.TRANS_LINEAR, $Tween.EASE_IN)
	
	$Tween.start()
