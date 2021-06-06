extends StaticBody2D

# gdscrip module
var rng = RandomNumberGenerator.new()


const juniper_berries = preload("res://props/berries_bush/juniper_berries.tscn")
const cranberries = preload("res://props/berries_bush/cranberries.tscn")
const drop_script = preload("res://scripts/item_drop.gd")

var have_berries:bool = false

var bush_type:String = ""

func _ready():
	
	if has_node("Timer"):
		var _Con0 = $Timer.connect("timeout", self, "_on_Timer_timeout")
	
	if has_node("hurtbox"):
		var _Con1 = get_node("hurtbox").connect("area_entered", self, "_on_hurtbox_area_entered")
	
	if has_node("check_in_bush"):
		var _Con2 = get_node("check_in_bush").connect("body_entered", self, "_on_check_in_bush_body_entered")
		var _Con3 = get_node("check_in_bush").connect("body_exited", self, "_on_check_in_bush_body_exited")
	
	bush_type = name.split("_")[0]
	make_bush()
	
		
func make_bush() -> void:
	if bush_type == null: return
	
	rng.randomize()
	var rand_timer = round(rng.randf_range(5,10))
	
	$Timer.set_wait_time(rand_timer)
	$Timer.start()

func drop_item():
	pass


# ----------------------------- Signal ---------------------------
func _on_check_in_bush_body_entered(body):
	if body.name == "player":
		game.player.player_in_props = true
	
func _on_check_in_bush_body_exited(body):
	if body.name == "player":
		game.player.player_in_props = false

func _on_hurtbox_area_entered(area):
	if area.name == "sword_hitbox" and have_berries:
		
		if bush_type == "juniper":
			if has_node("juniper_berries"):
				
				if game.inventory != null:
					var affectedSlot = DataParser.inventory_addItem(503)
					if (affectedSlot >= 0):
						game.inventory.update_slot(affectedSlot)
						
						game.reward_alert.add_reward_to_play(503)
						
				var drop_eff = load("res://effects/grass_drop_eff/grass_drop_eff.tscn").instance()
				drop_eff.global_position = global_position + Vector2(0,-24)
				get_tree().get_root().add_child(drop_eff)
				drop_eff.emitting = true
				
				get_node("juniper_berries").queue_free()
				
		elif bush_type == "cranberries":
			if has_node("cranberries"):
				
				if game.inventory != null:
					var affectedSlot = DataParser.inventory_addItem(502)
					if (affectedSlot >= 0):
						game.inventory.update_slot(affectedSlot)
						
						game.reward_alert.add_reward_to_play(502)
				
				var drop_eff = load("res://effects/grass_drop_eff/grass_drop_eff.tscn").instance()
				drop_eff.global_position = global_position + Vector2(0,-24)
				get_tree().get_root().add_child(drop_eff)
				drop_eff.emitting = true
				
				get_node("cranberries").queue_free()
				
		make_bush()
		have_berries = false
	
func _on_Timer_timeout():
	if bush_type == "juniper":
		var juniper_berries_obj = juniper_berries.instance()
		add_child(juniper_berries_obj)
		
	elif bush_type == "cranberries":
		var cranberries_obj = cranberries.instance()
		add_child(cranberries_obj)
	have_berries = true
