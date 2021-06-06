extends Area2D

var health = 2

var have_item_for_quest = false



func _on_grass_1_1_area_entered(area):
	if area.name != "sword_hitbox": return
	
	var drop_eff = load("res://effects/grass_drop_eff/grass_drop_eff.tscn").instance()
	drop_eff.global_position = global_position + Vector2(0,-24)
	get_tree().get_root().add_child(drop_eff)
	drop_eff.emitting = true
	
	health -= 1
	if health <= 0:
		
		drop_item()

func drop_item():
	
	#check_item_quest_drop()
	have_item_for_quest = checkquest.check_quest_drop(["903"])
	if have_item_for_quest:
		# แอดทั้งไอเทมเควสและไอเทมดรอป
		#make_drop_popup(self, "rabbit", ["202"], ["913"], 500, 1000)
		var material_drop = load("res://props/material_drop_item.gd").new()
		material_drop.add_material_item(self, "grass", ["103"], ["903"], 10, 10)

		
	else:
		# แอดไอเทมดรอป
		#make_drop_popup(self, "rabbit", ["202"], [], 500, 1000)
		if game.inventory != null:
			var affectedSlot = DataParser.inventory_addItem(103)
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
				
				game.reward_alert.add_reward_to_play(103)
				
	queue_free()

