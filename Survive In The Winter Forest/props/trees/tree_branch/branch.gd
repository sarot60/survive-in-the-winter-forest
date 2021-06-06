extends Node2D

var health: float = 100

func _ready():
	pass # Replace with function body.


func _on_hurtbox_area_entered(area):
	if area.name == "sword_hitbox":
		health -= 20
		if health <= 0:
			var affectedSlot = DataParser.inventory_addItem(3)
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
			queue_free()
