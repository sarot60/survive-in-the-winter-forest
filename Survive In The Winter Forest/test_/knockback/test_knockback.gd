extends KinematicBody2D

var knockback = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 500 * delta)
	knockback = move_and_slide(knockback)

func _on_hurtbox_area_entered(area):
	if area.name == "sword_hitbox":
		var direction = (area.player_position - global_position).normalized()
		knockback = -direction * 500
	
