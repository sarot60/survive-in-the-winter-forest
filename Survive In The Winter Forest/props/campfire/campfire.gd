extends Node2D

enum {
	FIRE_OFF,
	FIRE_ON
}

var campfire_state = FIRE_OFF

onready var light_a_fire = get_node("head_dialogue/light_a_fire")

var can_craft = false

var can_craft_style = StyleBoxFlat.new()
var cannot_craft_style = StyleBoxFlat.new()

var require_for_light = {
	"0": {
		"id": "101",
		"amount" : 10,
	},
	"1": {
		"id": "103",
		"amount": 10
	}
}

var tmp_data_require = {
	"0": {
		"id": "101",
		"slot": -1,
		"have": false,
		"amount": 0
	},
	"1": {
		"id": "103",
		"slot": -1,
		"have": false,
		"amount": 0
	}
}


func _ready():
	
	can_craft_style.set_bg_color(Color("#193214"))
	cannot_craft_style.set_bg_color(Color("#572210"))
	
	var _Con1 = $head_dialogue/light_a_fire.connect("mouse_entered",self ,"_on_light_a_fire_mouse_entered")
	var _Con2 = $head_dialogue/light_a_fire.connect("mouse_exited",self ,"_on_light_a_fire_mouse_exited")
			
func _on_player_detection_body_entered(body):
	if body.name == "player":
		match campfire_state:
			FIRE_OFF:
				light_a_fire.show()
				
				tmp_data_require = {
					"0": {
						"id": "101",
						"slot": -1,
						"have": false,
						"amount": 0
					},
					"1": {
						"id": "103",
						"slot": -1,
						"have": false,
						"amount": 0
					}
				}
				
				for slot in range(0,40):
					var inventoryItem:Dictionary = gamestate.state.inventory[str(slot)]
					#print(gamestate.state.inventory[str(slot)])
					
					if inventoryItem["id"] == require_for_light["0"]["id"]:
						#tmp_data_require["0"]["have"] = true
						tmp_data_require["0"]["amount"] += inventoryItem["amount"]
						tmp_data_require["0"]["slot"] = slot
					elif inventoryItem["id"] == require_for_light["1"]["id"]:
						#tmp_data_require["1"]["have"] = true
						tmp_data_require["1"]["amount"] += inventoryItem["amount"]
						tmp_data_require["1"]["slot"] = slot
				
				# 101
				if tmp_data_require["0"]["amount"] >= require_for_light["0"]["amount"]:
					#tmp_data_require["0"]["have"] == true:
					tmp_data_require["0"]["have"] = true
					$head_dialogue/light_a_fire/item_require/Panel/stick_require.set('custom_styles/panel', can_craft_style)
				else:
					tmp_data_require["0"]["have"] = false
					$head_dialogue/light_a_fire/item_require/Panel/stick_require.set('custom_styles/panel', cannot_craft_style)
				
				# 103
				if tmp_data_require["1"]["amount"] >= require_for_light["1"]["amount"]:
				#tmp_data_require["1"]["have"] == true:
					tmp_data_require["1"]["have"] = true
					$head_dialogue/light_a_fire/item_require/Panel/blade_of_grass_require.set('custom_styles/panel', can_craft_style)
				else:
					tmp_data_require["1"]["have"] = false
					$head_dialogue/light_a_fire/item_require/Panel/blade_of_grass_require.set('custom_styles/panel', cannot_craft_style)
				
				
				if tmp_data_require["0"]["have"] and tmp_data_require["1"]["have"]:
					light_a_fire.disabled = false
				else:
					light_a_fire.disabled = true
					
					
			FIRE_ON:
				$head_dialogue/food_processing.show()
				get_node("head_dialogue/food_processing").pre_processing_food()
				
func _on_player_detection_body_exited(body):
	if body.name == "player":
		match campfire_state:
			FIRE_OFF:
				light_a_fire.hide()
				$head_dialogue/food_processing.hide()
			FIRE_ON:
				light_a_fire.hide()
				$head_dialogue/food_processing.hide()
				
		check.mouse_on_gui = false
		
func _on_light_a_fire_pressed():
	$fire.visible = true
	$Light2D.visible = true
	
	light_a_fire.hide()
	
	campfire_state = FIRE_ON
	
	if game.inventory == null: return
	
	
	var drop_item_slot_0 = tmp_data_require["0"]["slot"]
	var drop_item_slot_1 = tmp_data_require["1"]["slot"]
	
	var newAmount0 = gamestate.state.inventory[str(drop_item_slot_0)]["amount"] - require_for_light["0"]["amount"]
	var newAmount1 = gamestate.state.inventory[str(drop_item_slot_1)]["amount"] - require_for_light["1"]["amount"]
	
	# item 2
	if newAmount0 < 1:
		DataParser.inventory_updateItem(drop_item_slot_0, 0, 0)
	else:
		gamestate.state.inventory[str(drop_item_slot_0)]["amount"] = newAmount0
		
	# item 2
	if newAmount1 < 1:
		DataParser.inventory_updateItem(drop_item_slot_1, 0, 0)
	else:
		gamestate.state.inventory[str(drop_item_slot_1)]["amount"] = newAmount1

	game.inventory.update_slot(drop_item_slot_0)
	game.inventory.update_slot(drop_item_slot_1)
	
	$head_dialogue/food_processing.show()

func _on_light_a_fire_mouse_entered():
	check.mouse_on_gui = true
	
func _on_light_a_fire_mouse_exited():
	check.mouse_on_gui = false


