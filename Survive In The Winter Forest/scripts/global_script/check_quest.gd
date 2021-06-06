extends Node


#var item_quest_table

# uuuuuuuuuuuuuuuu use in drop item popup หรือ หลังจากเก็บไอเทมนั่นเอง uuuuuuuuuuuuuu
func update_quest_status() -> void:
	
	if gamestate.state.quest.success_all == 1: return
	
	var check_success_quest = 0
	
	for i in gamestate.state.quest.tmp_item_quest:
		if gamestate.state.quest.tmp_item_quest[str(i)] == 0:
			check_success_quest += 1
			
			
	if check_success_quest == 0:
		gamestate.state.quest.success_current_quest = 1
		get_tree().call_group("check_current_quest_success","switch_quest_status",self)
	
	
# เช็คก่อนทำการดรอปไอเทม
# uuuuuuuuuuuuuu use in rabbit uuuuuuuuuuuuuu
# ใช้สำหรับเช็คทุกอย่างที่ดรอปเควส
func check_quest_drop(item_quest_key:Array) -> bool:

	# ทำเควสหมดแล้ว
	if gamestate.state.quest.success_all == 1: return false
	
	# ยังไม่รับเควส
	if gamestate.state.quest.accepted_quest == 0: return false
	
	# เควสปัจจุบันเสร็จแล้ว
	if gamestate.state.quest.success_current_quest == 1: return false
	
	if item_quest_key.size() < 1: return false
	
	for i in item_quest_key:
		
		# ลูปไอเทมที่ต้องการทั้งหมด
		for j in JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"]:
			
			# ถ้าไอเทมที่ต้องการในปัจจุบันเป็นของที่ต้องการเช่น เนื้อกระต่าย
			if JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][str(j)] == i:
				
				# ถ้าในตัวยังไม่มี
				if gamestate.state.quest["tmp_item_quest"][i] == 0:
					return true
	return false

