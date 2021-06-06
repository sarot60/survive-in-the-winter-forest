extends Node

var item_drop_list:Array = []
var quest_drop_list:Array = []
var exp_reward:int = 0
var money_reward:int = 0
var parent_obj:Object = null
var is_material_type:String = ""


func add_material_item(obj:Object, material_type:String, item_key:Array ,item_quest_key:Array ,experience:int ,money:int) -> void:
	self.item_drop_list = item_key
	self.quest_drop_list = item_quest_key
	self.parent_obj = obj
	self.exp_reward = experience
	self.money_reward = money
	self.is_material_type = material_type

	# --
	
	if money_reward == 0: return
	if exp_reward == 0: return
	if is_material_type == "": return
	if parent_obj == null: return
	
	if game.inventory == null: return
	
	if item_drop_list.size() > 0:
		for i in item_drop_list:
			var affectedSlot = DataParser.inventory_addItem(int(i))
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
				game.reward_alert.add_reward_to_play(int(i))
				
	# ถ้ามีเควส
	if quest_drop_list.size() > 0:
		for i in quest_drop_list:
			var affectedSlot = DataParser.inventory_addItem(int(i))
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
				
				# quest
				gamestate.state.quest["tmp_item_quest"][str(i)] = 1
				checkquest.update_quest_status()
				
				game.reward_alert.add_reward_to_play(int(i))
				
				# update hud current_quest
				if game.hud != null:
					game.hud.get_node("current_quest").update_current_quest_hud()
