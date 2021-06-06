extends CanvasLayer

var page = 0

var self_npc = null

var first_talk_dialog = false
var quest_talk_dialog = false

onready var dialog_text = $dialog_panel/dialog_text

#var dialog_json = {
#	"bravo":{
#		"0":"Hello",
#		"1":"I am NPC 01",
#		"2":"Help me please"
#	},
#	"02":{
#		"0":"Hello",
#		"1":"I am NPC 02"
#	},
#	"03":{
#		"0":"Hello",
#		"1":"I am NPC 03"
#	},
#}

func _ready():
	
	set_process_input(false)
	
	$dialog_panel.hide()
	
	var _tmp1 = $dialog_panel/button_group/close_button.connect("pressed", self,"_on_close_button_pressed")
	var _tmp2 = $dialog_panel/button_group/quest_button.connect("pressed", self,"_on_quest_button_pressed")
	var _tmp3 = $dialog_panel/button_group/shop_button.connect("pressed", self,"_on_shop_button_pressed")
	var _tmp4 = $dialog_panel/button_group/accept_quest_button.connect("pressed", self,"_on_accept_quest_button_pressed")
	var _tmp5 = $dialog_panel/button_group/success_quest.connect("pressed", self,"_on_success_quest_button_pressed")
	
	var _tmx = get_node("dialog_panel").connect("mouse_entered", self, "_on_check_mouse_panel_entered")
	var _tm2o = get_node("dialog_panel").connect("mouse_exited", self, "_on_check_mouse_panel_exited")
	
	var _2kasd = get_node("dialog_panel/dialog_text").connect("mouse_entered", self, "_on_check_mouse_panel_entered")
	var _231 = get_node("dialog_panel/dialog_text").connect("mouse_exited", self, "_on_check_mouse_panel_exited")
	
	for i in get_node("dialog_panel/button_group").get_children():
		var _x = i.connect("mouse_entered", self, "_on_check_mouse_panel_entered")
		var _y = i.connect("mouse_exited", self, "_on_check_mouse_panel_exited")

func _input(event):
	if first_talk_dialog:
		#if event is InputEventMouseButton or Input.is_action_just_pressed("ui_select") and event.is_pressed():
		if event.is_action_pressed("ui_select"):
			if dialog_text.get_visible_characters() > dialog_text.get_total_character_count():
				if page < JsonGameMetaData.npc[self_npc.npc_name]["talk_dialog"].size()-1:
					page += 1
					dialog_text.set_bbcode(JsonGameMetaData.npc[self_npc.npc_name]["talk_dialog"][String(page)])
					dialog_text.set_visible_characters(0)
			else:
				dialog_text.set_visible_characters(dialog_text.get_total_character_count())
	elif quest_talk_dialog:
		if event.is_action_pressed("ui_select"):
			if dialog_text.get_visible_characters() > dialog_text.get_total_character_count():
				if page < JsonGameMetaData.quest[self_npc.current_quest]["quest_dialog"].size()-1:
					page += 1
					dialog_text.set_bbcode(JsonGameMetaData.quest[self_npc.current_quest]["quest_dialog"][String(page)])
					dialog_text.set_visible_characters(0)
			else:
				dialog_text.set_visible_characters(dialog_text.get_total_character_count())

func first_start_dialog():
	
	$dialog_panel/button_group/shop_button.disabled = false
	$dialog_panel/button_group/close_button.disabled = false
	$dialog_panel/button_group/quest_button.disabled = false
	$dialog_panel/button_group/accept_quest_button.disabled = false
	$dialog_panel/button_group/success_quest.disabled = false
	
	#if !dialog_json.has(npc_name):
	if !JsonGameMetaData.npc.has(self_npc.npc_name):
		return
	
	first_talk_dialog = true
	quest_talk_dialog = false
	
	set_process_input(true)
	
	dialog_text.set_bbcode(JsonGameMetaData.npc[self_npc.npc_name]["talk_dialog"][String(page)])
	dialog_text.set_visible_characters(0)
	dialog_text.set_process_input(true)
	
	$first_dialog_timer.start()
	$quest_dialog_timer.stop()
	
func quest_start_dialog():
	
	$dialog_panel/button_group/shop_button.disabled = false
	$dialog_panel/button_group/close_button.disabled = false
	$dialog_panel/button_group/quest_button.disabled = false
	$dialog_panel/button_group/accept_quest_button.disabled = false
	$dialog_panel/button_group/success_quest.disabled = false
	
	#if !dialog_json.has(npc_name):
	#	return
	if !JsonGameMetaData.quest.has(self_npc.current_quest):
		return
	
	first_talk_dialog = false
	quest_talk_dialog = true
	
	set_process_input(true)
	
	dialog_text.set_bbcode(JsonGameMetaData.quest[self_npc.current_quest]["quest_dialog"][String(page)])
	dialog_text.set_visible_characters(0)
	dialog_text.set_process_input(true)
	
	$quest_dialog_timer.start()
	$first_dialog_timer.stop()

func initial_dialog(objcet_npc):
	
	self_npc = objcet_npc
	
	$dialog_panel.show()
	$dialog_panel/name.text = JsonGameMetaData.npc[self_npc.npc_name]["name"]
	
	page = 0
	first_start_dialog()


func close_dialog():
	$dialog_panel/button_group/shop_button.disabled = true
	$dialog_panel/button_group/close_button.disabled = true
	$dialog_panel/button_group/quest_button.disabled = true
	$dialog_panel/button_group/accept_quest_button.disabled = true
	$dialog_panel/button_group/success_quest.disabled = true
	
	$dialog_panel/button_group/shop_button.hide()
	$dialog_panel/button_group/close_button.hide()
	$dialog_panel/button_group/quest_button.hide()
	$dialog_panel/button_group/accept_quest_button.hide()
	$dialog_panel/button_group/success_quest.hide()
	
	set_process_input(false)
	
	first_talk_dialog = false
	quest_talk_dialog = false
	
	$dialog_panel.hide()
	
	$first_dialog_timer.stop()
	$quest_dialog_timer.stop()
	
	self_npc = null

# ------------------------ Signals ---------------------------

func _on_close_button_pressed():
	#print('close')
	self_npc.close_npc()
	
func _on_quest_button_pressed():
	page = 0
	quest_start_dialog()
	
	$dialog_panel/button_group/shop_button.hide()
	$dialog_panel/button_group/close_button.hide()
	$dialog_panel/button_group/quest_button.hide()

func _on_shop_button_pressed():
	set_process_input(false)

	first_talk_dialog = false
	quest_talk_dialog = false

	$dialog_panel/button_group/shop_button.hide()
	$dialog_panel/button_group/close_button.hide()
	$dialog_panel/button_group/quest_button.hide()
	$dialog_panel/button_group/accept_quest_button.hide()
	$dialog_panel/button_group/success_quest.hide()

	$dialog_panel.hide()

	$first_dialog_timer.stop()
	$quest_dialog_timer.stop()

	if self_npc.has_method("show_general_shop"):
		self_npc.show_general_shop()
	
func _on_accept_quest_button_pressed():
	game.text_alert.add_data_to_play("รับเควสสำเร็จแล้ว")
	
	gamestate.state.quest.accepted_quest = 1
	
	
	#print(JsonGameMetaData.quest[self_npc.current_quest]["item_quest_require"])
	gamestate.state.quest["tmp_item_quest"] = {}
	
	for i in JsonGameMetaData.quest[self_npc.current_quest]["item_quest_require"]:
		#print(JsonGameMetaData.quest[self_npc.current_quest]["item_quest_require"][str(i)])
		gamestate.state.quest["tmp_item_quest"][JsonGameMetaData.quest[self_npc.current_quest]["item_quest_require"][str(i)]] = 0
	
	# update hud current_quest
	if game.hud != null:
		game.hud.get_node("current_quest").update_current_quest_hud()
		
	self_npc.close_npc()

func _on_success_quest_button_pressed() -> void:
	self_npc.close_npc()
	
	game.text_alert.add_data_to_play("ส่งเควสสำเร็จแล้ว")
	
	# exp + 
	# money +
	
	if gamestate.state.quest.success_all == 1: return
	
	gamestate.state.quest.accepted_quest = 0
	gamestate.state.quest.success_current_quest = 0
	gamestate.state.quest.tmp_item_quest = {}
	
	# ให้รางวัลก่อนนะจ๊ะ
	game.inventory.inventory_remove_all_item_quest()

	var rewards = JsonGameMetaData.quest[gamestate.state.quest.current_quest].rewards
	game.player_detail.increase_exp(rewards["exp"])
	gamestate.state.money += rewards["money"] 
	gamestate.state.perk_point += rewards["perk_point"]
	
	
	# ไปเควสใหม่
	var cur_q = int(gamestate.state.quest.current_quest) + 1
	var str_cur_q = "00" + str(cur_q)
	print(str_cur_q)
	gamestate.state.quest.current_quest = str_cur_q
	
#	var str_cur_q = null
#	if gamestate.state.quest.current_quest == "001":
#		gamestate.state.quest.current_quest = "002"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "002":
#		gamestate.state.quest.current_quest = "003"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "003":
#		gamestate.state.quest.current_quest = "004"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "004":
#		gamestate.state.quest.current_quest = "005"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "005":
#		gamestate.state.quest.current_quest = "006"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "006":
#		gamestate.state.quest.current_quest = "007"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "007":
#		gamestate.state.quest.current_quest = "008"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "008":
#		gamestate.state.quest.current_quest = "009"
#		str_cur_q = gamestate.state.quest.current_quest
#	elif gamestate.state.quest.current_quest == "009":
#		gamestate.state.quest.current_quest = "0010"
#		str_cur_q = gamestate.state.quest.current_quest

	# จบเควสทั้งหมด
	if str_cur_q == "0010":
		gamestate.state.quest.success_all = 1
	
	# update hud current_quest
	if game.hud != null:
		game.hud.get_node("current_quest").update_current_quest_hud()
	
	# call to npc object
	get_tree().call_group("check_current_quest_success","switch_quest_status",self)
	
	return
	
func _on_first_dialog_timer_timeout():
	
	dialog_text.set_visible_characters(dialog_text.get_visible_characters()+1)
	
	if dialog_text.get_visible_characters() > dialog_text.get_total_character_count():
		if page == JsonGameMetaData.npc[self_npc.npc_name]["talk_dialog"].size()-1:
			if self_npc.npc_type == "merchant":
				$dialog_panel/button_group/shop_button.show()
			
			if gamestate.state.quest.success_all != 1:
				if self_npc.is_current_quest:
					$dialog_panel/button_group/quest_button.show()
			
			$dialog_panel/button_group/close_button.show()
			
			$first_dialog_timer.stop()
			$quest_dialog_timer.stop()

func _on_quest_dialog_timer_timeout():
	
	dialog_text.set_visible_characters(dialog_text.get_visible_characters()+1)
	
	if dialog_text.get_visible_characters() > dialog_text.get_total_character_count():
		if page == JsonGameMetaData.quest[self_npc.current_quest]["quest_dialog"].size()-1:
			if gamestate.state.quest.accepted_quest == 0:
				$dialog_panel/button_group/accept_quest_button.show()
			
			if gamestate.state.quest.success_current_quest == 1:
				$dialog_panel/button_group/success_quest.show()
			
			$dialog_panel/button_group/close_button.show()
			
			$quest_dialog_timer.stop()
			$quest_dialog_timer.stop()

func _on_check_mouse_panel_entered():
	check.mouse_on_gui = true

func _on_check_mouse_panel_exited():
	check.mouse_on_gui = false
