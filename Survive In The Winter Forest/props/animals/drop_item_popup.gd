extends Node2D

var item_drop_list:Array = []
var quest_drop_list:Array = []
var exp_reward:int = 0
var money_reward:int = 0
var parent_obj:Object = null
var is_animal_type:String = ""

func _ready():
	var _tmpCon_en = $bg/check_mouse_panel.connect("mouse_entered", self, "_on_check_mouse_panel_entered")
	var _tmpCon1_en = $bg/pick_button.connect("mouse_entered", self, "_on_check_mouse_panel_entered")
	
	var _tmpCon_ex = $bg/check_mouse_panel.connect("mouse_exited", self, "_on_check_mouse_panel_exited")
	var _tmpCon1_ex = $bg/pick_button.connect("mouse_exited", self, "_on_check_mouse_panel_exited")

func set_data(obj:Object, animal_type:String, item_key:Array ,item_quest_key:Array ,experience:int ,money:int) -> void:
	hide()
	
	self.parent_obj = obj
	self.is_animal_type = animal_type
	self.item_drop_list = item_key
	self.exp_reward = experience
	self.money_reward = money
	self.quest_drop_list = item_quest_key
	

	# ถ้าเป็นไอเทมเควส กำหนดพื้นหลังเป็นสีฟ้า
	if JsonGameMetaData.item_meta_data[item_key[0]].type == "quest":
		get_node("bg/ScrollContainer/GridContainer/itm_0/itm_bg").color = Color(0.06, 0.16, 0.36, 1)

	get_node("bg/ScrollContainer/GridContainer/itm_0/itm_bg/itm_icon").texture = load(str(JsonGameMetaData.item_meta_data[item_key[0]].icon))
	
	var tmpStr1:String = ""
	tmpStr1 = str(JsonGameMetaData.item_meta_data[item_key[0]].name) + "\n"
	tmpStr1 = tmpStr1 + str(JsonGameMetaData.item_meta_data[item_key[0]].thai_name) + "\n"
	tmpStr1 = tmpStr1 + "x1"
	$bg/ScrollContainer/GridContainer/itm_0/itm_detail.text = tmpStr1
	
	var tmpStr2:String = ""
	tmpStr2 = "ค่าประสบการณ์ = " + str(experience) + "\n"
	tmpStr2 = tmpStr2 + "เงิน = " + str(money)
	$bg/exp_money_reward_bg/RichTextLabel.text = tmpStr2
	
	# ถ้าต้องการ drop มากกว่า 1 ชิ้น
	if item_key.size() > 1:
		for i in range(1, item_key.size()):
			var itm_panel_obj = get_node("bg/ScrollContainer/GridContainer/itm_0").duplicate()
			itm_panel_obj.get_node("itm_bg/itm_icon").texture = load(str(JsonGameMetaData.item_meta_data[item_key[i]].icon))
			
			var tmpStr3:String = ""
			tmpStr3 = str(JsonGameMetaData.item_meta_data[item_key[0]].name) + "\n"
			tmpStr3 = tmpStr3 + str(JsonGameMetaData.item_meta_data[item_key[0]].thai_name) + "\n"
			tmpStr3 = tmpStr3 + "x1"
			itm_panel_obj.get_node("itm_detail").text = tmpStr3
			
			get_node("bg/ScrollContainer/GridContainer").add_child(itm_panel_obj)
			
	# ถ้ามีเควส
	if item_quest_key.size() > 0:
		for i in item_quest_key:
			var itm_panel_obj = get_node("bg/ScrollContainer/GridContainer/itm_0").duplicate()
			
			# ถ้าเป็นไอเทมเควส กำหนดพื้นหลังเป็นสีฟ้า
			if JsonGameMetaData.item_meta_data[i].type == "quest":
				itm_panel_obj.get_node("itm_bg").color = Color(0.06, 0.16, 0.36, 1)
				
			var tmpStr4:String = ""
			tmpStr4 = str(JsonGameMetaData.item_meta_data[item_key[0]].name) + "\n"
			tmpStr4 = tmpStr4 + str(JsonGameMetaData.item_meta_data[item_key[0]].thai_name) + "\n"
			tmpStr4 = tmpStr4 + "x1"
			itm_panel_obj.get_node("itm_detail").text = tmpStr4
			
			itm_panel_obj.get_node("itm_bg/itm_icon").texture = load(str(JsonGameMetaData.item_meta_data[i].icon))
			get_node("bg/ScrollContainer/GridContainer").add_child(itm_panel_obj)

func _on_pick_button_pressed():
	if money_reward == 0: return
	if exp_reward == 0: return
	if is_animal_type == "": return
	if parent_obj == null: return
	
	if game.inventory == null: return
	
	# ให้รางวัลก่อน
	gamestate.state.money += money_reward
	game.player_detail.increase_exp(exp_reward)
	
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
			
	if is_animal_type == "rabbit":
		parent_obj._pick_item_is_success()
		gamestate.state["rabbit_kill"] += 1
	elif is_animal_type == "wolf":
		parent_obj._pick_item_is_success()
		gamestate.state["wolf_kill"] += 1
	elif is_animal_type == "deer":
		parent_obj._pick_item_is_success()
		gamestate.state["deer_kill"] += 1
		
	check.mouse_on_gui = false

func _on_check_mouse_panel_entered():
	check.mouse_on_gui = true

func _on_check_mouse_panel_exited():
	check.mouse_on_gui = false
