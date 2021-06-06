extends Node2D

func create_grass_effect():
	print("Grass Effect")
	pass

func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
