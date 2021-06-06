extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	#initiate()
	pass

func initiate():
	# ถ้ารับเควสปัจจุบันแล้ว
	#return
	if gamestate.state.quest.accepted_quest == 1:
		
		var msg = ""
		msg = "ไอเทมที่ต้องการ \n==================\n"
		
		# ลุูปไอเทมเควสที่ต้องการ
		for i in JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"]:
			var quest_req_thai_name = JsonGameMetaData.item_meta_data[JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][i]].thai_name
			var count_req = str(gamestate.state.quest["tmp_item_quest"][JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][i]])+"/1"
			
			if gamestate.state.quest["tmp_item_quest"][JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][i]] > 0:
				msg = msg + "[color=#33c333]" +  str(quest_req_thai_name) + " " + count_req + "[/color]\n"
			else:
				msg = msg + str(quest_req_thai_name) + " " + count_req + "\n"
			
		#$Panel/RichTextLabel.text = msg
		$Panel/RichTextLabel.set_bbcode(msg)
		$Panel/RichTextLabel.self_modulate = Color(1, 1, 1, 0.8)
	# ถ้ายังไม่รับเควสปัจจุบัน
	else:
		$Panel/RichTextLabel.set_bbcode("[color=#cecece]เควสปัจจุบันยังไม่ได้รับ กรุณารับเควสกับ NPC ที่อยู่ในหมู่บ้าน[/color]")
		#$Panel/RichTextLabel.text = "เควสปัจจุบันยังไม่ได้รับ กรุณารับเควสกับ NPC ที่อยู่ในหมู่บ้าน"
		$Panel/RichTextLabel.self_modulate = Color(1, 1, 1, 0.7)
	

func update_current_quest_hud():
	initiate()


