extends Node

#var save_path = "user://gamestate.dat"

onready var file = File.new()

func _ready():
	pass

func load_data(url) -> Dictionary:
	if url == null: return {}
	if !file.file_exists(url): return {}
	file.open(url, File.READ)
	var data:Dictionary = {}
	data = parse_json(file.get_as_text())
	file.close()
	return data

func write_data(url:String, dict:Dictionary):
	if url == null: return
	file.open(url, File.WRITE)
	file.store_line(to_json(dict))
	file.close()
	
func get_item(id:String) -> Dictionary:
	if !JsonGameMetaData.item_meta_data.has(id):
		print("Item does not exist.")
		return {}

	JsonGameMetaData.item_meta_data[(id)]["id"] = (id)
	return JsonGameMetaData.item_meta_data[(id)]

func inventory_getItem(slot:int) -> Dictionary:
	return gamestate.state.inventory[str(slot)]

func inventory_getEmptySlot() -> int:
	for slot in range(0, 40):
		if (gamestate.state.inventory[str(slot)]["id"] == "0"): 
			return int(slot)
	print ("Inventory is full!")
	return -1

func inventory_addItem(itemId:int) -> int:
	var itemData:Dictionary = DataParser.get_item(str(itemId))
	if (itemData.empty()): 
		return -1
	if (int(itemData["stack_limit"]) <= 1):
		var slot = inventory_getEmptySlot()
		if (slot < 0): 
			return -1
		gamestate.state.inventory[String(slot)] = {"id": String(itemId), "amount": 1}
		return slot
		

	for slot in range (0, 40):
		if (gamestate.state.inventory[String(slot)]["id"] == String(itemId)):
			if (int(itemData["stack_limit"]) > int(gamestate.state.inventory[String(slot)]["amount"])):
				gamestate.state.inventory[String(slot)]["amount"] = int(gamestate.state.inventory[String(slot)]["amount"] + 1)
				return slot

	var slot = inventory_getEmptySlot()
	if (slot < 0): 
		return -1
	gamestate.state.inventory[String(slot)] = {"id": String(itemId), "amount": 1}
	return slot

func inventory_removeItem(slot) -> int:
	var newAmount = gamestate.state.inventory[String(slot)]["amount"] - 1
	if (newAmount < 1):
		inventory_updateItem(slot, 0, 0)
		return 0
	gamestate.state.inventory[String(slot)]["amount"] = newAmount
	return newAmount
	
func inventory_mergeItem(fromSlot:int, toSlot:int) -> void:
	if (fromSlot < 0 or toSlot < 0):
		return
	
	var fromSlot_invData:Dictionary = gamestate.state.inventory[str(fromSlot)]
	var toSlot_invData:Dictionary = gamestate.state.inventory[str(toSlot)]
	
	var toSlot_stackLimit:int = (DataParser.get_item(gamestate.state.inventory[str(toSlot)]["id"])["stack_limit"])
	var fromSlot_stackLimit:int = (DataParser.get_item(gamestate.state.inventory[str(fromSlot)]["id"])["stack_limit"])
	
	if (toSlot_stackLimit <= 1 or fromSlot_stackLimit <=1):
		return
		
	if (fromSlot_invData["id"] != toSlot_invData["id"]):
		return
	if (int(toSlot_invData["amount"]) >= toSlot_stackLimit or int(fromSlot_invData["amount"] >= toSlot_stackLimit)):
		inventory_moveItem(fromSlot, toSlot)
		return
	
	var toSlot_newAmount:int = (toSlot_invData["amount"]) + (fromSlot_invData["amount"])
	var fromSlot_newAmount:int = 0
	if (toSlot_newAmount > toSlot_stackLimit):
		fromSlot_newAmount = toSlot_newAmount - toSlot_stackLimit
		inventory_updateItem(toSlot, int(gamestate.state.inventory[str(toSlot)]["id"]), toSlot_stackLimit)
		inventory_updateItem(fromSlot, int(gamestate.state.inventory[str(fromSlot)]["id"]), fromSlot_newAmount)
	else:
		inventory_updateItem(toSlot, int(gamestate.state.inventory[str(toSlot)]["id"]), toSlot_newAmount)
		inventory_updateItem(fromSlot, 0, 0)

func inventory_updateItem(slot:int, new_id:int, new_amount:int) -> void:
	if (slot < 0):
		return
	if (new_amount < 0):
		return
	if (DataParser.get_item(str(new_id)).empty()):
		return
	gamestate.state.inventory[str(slot)] = {"id": str(new_id), "amount": int(new_amount)}
	
func inventory_moveItem(fromSlot:int, toSlot:int) -> void:
	var temp_ToSlotItem:Dictionary = gamestate.state.inventory[str(toSlot)]
	gamestate.state.inventory[str(toSlot)] = gamestate.state.inventory[str(fromSlot)]
	gamestate.state.inventory[str(fromSlot)] = temp_ToSlotItem
	
	

