extends Node

var health = 3

const herb = {
	"mint_tree": 301,
	"rosemary_tree": 302,
	"parsley_tree": 303,
	"thyme_tree": 304,
	"winter_savory_tree": 305,
	"basil_tree": 306,
	"sage_tree": 307,
	"chives_tree": 308,
	"oregano_tree": 309,
	"catnip_tree": 310,
	"sorrel_tree": 311,
	"caraway_tree": 312,
	"tarragon_tree": 313,
	"horseradish_tree": 314
}

const herb_quest = {
	"mint_tree": 915,
	"rosemary_tree": 916,
	"parsley_tree": 917,
	"thyme_tree": 918,
	"winter_savory_tree": 919,
	"basil_tree": 920,
	"sage_tree": 921,
	"chives_tree": 922,
	"oregano_tree": 923,
	"catnip_tree": 924,
	"sorrel_tree": 925,
	"caraway_tree": 926,
	"tarragon_tree": 927,
	"horseradish_tree": 928
}

const herb_qr_img = {
	"mint_tree": "res://assets/herb_qrcode_img/mint-qr-code.png",
	"rosemary_tree": "res://assets/herb_qrcode_img/rosemary-qr-code.png",
	"parsley_tree": "res://assets/herb_qrcode_img/parsley-qr-code.png",
	"thyme_tree": "res://assets/herb_qrcode_img/thyme-qr-code.png",
	"winter_savory_tree": "res://assets/herb_qrcode_img/winter_savory-qr-code.png",
	"basil_tree": "res://assets/herb_qrcode_img/basil-qr-code.png",
	"sage_tree": "res://assets/herb_qrcode_img/sage-qr-code.png",
	"chives_tree": "res://assets/herb_qrcode_img/chives-qr-code.png",
	"oregano_tree": "res://assets/herb_qrcode_img/oregano-qr-code.png",
	"catnip_tree": "res://assets/herb_qrcode_img/catnip-qr-code.png",
	"sorrel_tree": "res://assets/herb_qrcode_img/sorrel-qr-code.png",
	"caraway_tree": "res://assets/herb_qrcode_img/caraway-qr-code.png",
	"tarragon_tree": "res://assets/herb_qrcode_img/tarragon-qr-code.png",
	"horseradish_tree": "res://assets/herb_qrcode_img/horseradish-qr-code.png"
}

const herb_pick = preload("res://props/herb_tree/herb_pick_popup.tscn")

var self_herb_name

func _ready():
	
	if has_node("hurtbox"):
		var _Con1 = get_node("hurtbox").connect("area_entered",self,"_on_hurtbox_area_entered")
	
	self_herb_name = name.split("[")[0]
	
	if has_node("player_detection"):
		var _tmpCon1 = get_node("player_detection").connect("body_entered", self, "_on_player_detection_body_entered")
		var _tmpCon2 = get_node("player_detection").connect("body_exited", self, "_on_player_detection_body_exited")
	
	if !has_node("herb_pick_popup"):
		var herb_pick_obj = herb_pick.instance()
		add_child(herb_pick_obj)
		
		var _tmpCon1 = herb_pick_obj.get_node("bg/pick_button").connect("pressed", self, "_on_pick_button_pressed")
		
		var icon_path = JsonGameMetaData.item_meta_data[str(herb[self_herb_name])].icon
		herb_pick_obj.get_node("bg").get_node("herb_icon").texture = load(icon_path)
		
		if self_herb_name == "winter_savory_tree":
			herb_pick_obj.get_node("bg").get_node("herb_name").text = self_herb_name.split('_')[0].to_upper() +" "+ self_herb_name.split('_')[1].to_upper()
		else:
			herb_pick_obj.get_node("bg").get_node("herb_name").text = self_herb_name.split('_')[0].to_upper()
		
		var detail_str:String = ""
		for i in JsonGameMetaData.item_meta_data[str(herb[self_herb_name])].details:
			var _tmpStr:String = str(int(i)+1)+". " + JsonGameMetaData.item_meta_data[str(herb[self_herb_name])].details[i]
			detail_str = detail_str + _tmpStr + "\n"
		herb_pick_obj.get_node("bg").get_node("detail_bg/RichTextLabel").text = detail_str
		
		# ใส่รูป qr code
		herb_pick_obj.get_node("bg/qrcode_img").texture = load(herb_qr_img[self_herb_name])
		
		herb_pick_obj.hide()
		
# ------------------------------------- Signals -------------------------------------
func _on_player_detection_body_entered(body):
	if has_node("player_detection") and body.name == "player":
		if has_node("herb_pick_popup"):
			get_node("herb_pick_popup").show()
func _on_player_detection_body_exited(body):
	if has_node("player_detection") and body.name == "player":
		if has_node("herb_pick_popup"):
			get_node("herb_pick_popup").hide()

func _on_pick_button_pressed():
	if !has_node("herb_pick_popup"): return
	
	gamestate.state.herb_tree[name.split('[')[0]] = 0
	
	if game.inventory == null: return
	
	check_item_quest_drop()
	
	var _ret = name.split('[')[0]
	var affectedSlot = DataParser.inventory_addItem(herb[_ret])
	if (affectedSlot >= 0):
		game.inventory.update_slot(affectedSlot)
		
	game.reward_alert.add_reward_to_play(herb[_ret])
	
	# call to herb_tree_env_map
	get_tree().call_group("delete_herb_tree_marker","delete_herb_tree_marker", true)
	
	if name.split('[')[0] == "mint_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_mint()
	elif name.split('[')[0] == "rosemary_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_rosemary()
	elif name.split('[')[0] == "parsley_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_parsley()
	elif name.split('[')[0] == "thyme_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_thyme()
	elif name.split('[')[0] == "winter_savory_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_winter_savory()
	elif name.split('[')[0] == "basil_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_basil()
	elif name.split('[')[0] == "sage_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_sage()
	elif name.split('[')[0] == "chives_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_chives()
	elif name.split('[')[0] == "oregano_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_oregano()
	elif name.split('[')[0] == "catnip_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_catnip()
	elif name.split('[')[0] == "sorrel_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_sorrel()
	elif name.split('[')[0] == "caraway_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_caraway()
	elif name.split('[')[0] == "tarragon_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_tarragon()
	elif name.split('[')[0] == "horseradish_tree":
		game.main_map.get_node("YSort/herb_tree_env_map").reload_horseradish()
		
	queue_free()

func _on_hurtbox_area_entered(area):
	if area.name != "sword_hitbox": return
#	health -= 1
#	if health <= 0:
#		gamestate.state.herb_tree[name.split('[')[0]] = 0
#
#		if game.inventory == null: return
#
#		check_item_quest_drop()
#
#		var _ret = name.split('[')[0]
#		var affectedSlot = DataParser.inventory_addItem(herb[_ret])
#		if (affectedSlot >= 0):
#			game.inventory.update_slot(affectedSlot)
#
#		get_tree().call_group("delete_herb_tree_marker","delete_herb_tree_marker", true)
#
#		#print(game.main_map.get_node("YSort/herb_tree_env_map"))
#		if name.split('[')[0] == "mint_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_mint()
#		elif name.split('[')[0] == "rosemary_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_rosemary()
#		elif name.split('[')[0] == "parsley_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_parsley()
#		elif name.split('[')[0] == "thyme_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_thyme()
#		elif name.split('[')[0] == "winter_savory_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_winter_savory()
#		elif name.split('[')[0] == "basil_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_basil()
#		elif name.split('[')[0] == "sage_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_sage()
#		elif name.split('[')[0] == "chives_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_chives()
#		elif name.split('[')[0] == "oregano_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_oregano()
#		elif name.split('[')[0] == "catnip_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_catnip()
#		elif name.split('[')[0] == "sorrel_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_sorrel()
#		elif name.split('[')[0] == "caraway_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_caraway()
#		elif name.split('[')[0] == "tarragon_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_tarragon()
#		elif name.split('[')[0] == "horseradish_tree":
#			game.main_map.get_node("YSort/herb_tree_env_map").reload_horseradish()
#
#		queue_free()
		
func check_item_quest_drop():
	
	# ทำเควสหมดแล้ว
	if gamestate.state.quest.success_all == 1: return
	
	# ยังไม่รับเควส
	if gamestate.state.quest.accepted_quest == 0: return
	
	# เควสปัจจุบันเสร็จแล้ว
	if gamestate.state.quest.success_current_quest == 1: return
	
	var _ret = name.split('[')[0]
	
	for i in JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"]:
		
		# ถ้าสมุนไพรปัจจุบันเป็นที่ต้องการ
		if JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][str(i)] == str(herb_quest[_ret]):
			
			# ถ้ายังไม่เก็บ
			if gamestate.state.quest["tmp_item_quest"][str(herb_quest[_ret])] == 0:
				
				var affectedSlot = DataParser.inventory_addItem(herb_quest[_ret])
				if (affectedSlot >= 0):
					game.inventory.update_slot(affectedSlot)
					
					# quest
					gamestate.state.quest["tmp_item_quest"][str(herb_quest[_ret])] = 1
					checkquest.update_quest_status()
					
					# update hud current_quest
					if game.hud != null:
						game.hud.get_node("current_quest").update_current_quest_hud()
				return
	

