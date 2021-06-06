extends Control

var activeItemSlot:int = -1
var dropItemSlot:int = -1

onready var isDraggingItem:bool = false
onready var mouseButtonReleased:bool = true
var draggedItemSlot:int = -1
onready var initial_mousePos:Vector2 = Vector2()
onready var cursor_insideItemList:bool = false

var isAwaitingSplit:bool = false
var splitItemSlot:int = -1

func _ready():
	game.inventory = self
	
	# initialize itle list
	$Panel/ItemList.set_max_columns(10)
	$Panel/ItemList.set_fixed_icon_size(Vector2(64,64))
	$Panel/ItemList.set_icon_mode($Panel/ItemList.ICON_MODE_TOP)
	$Panel/ItemList.set_select_mode($Panel/ItemList.SELECT_SINGLE)
	$Panel/ItemList.set_same_column_width(true)
	$Panel/ItemList.set_allow_rmb_select(true)
	
	#load_items()
	
	set_process(false)
	set_process_input(true)
	
	
#warning-ignore:unused_argument
func _process(delta) -> void:
	if (isDraggingItem):
		$Panel/Sprite_DraggedItem.global_position = get_viewport().get_mouse_position()

func _input(event):
	if (event is InputEventMouseButton):
		if (!isAwaitingSplit):
			if (event.is_action_pressed("left_click")):
				mouseButtonReleased = false
				initial_mousePos = get_viewport().get_mouse_position()
			if (event.is_action_released("left_click")):
				move_merge_item()
				end_drag_item()
				pass
		else:
			if (event.is_action_pressed("right_click")):
				if (activeItemSlot >= 0):
					#begin_split_item()
					pass
					
	if (event is InputEventMouseMotion):
		if (cursor_insideItemList):
			activeItemSlot = $Panel/ItemList.get_item_at_position($Panel/ItemList.get_local_mouse_position(),true)
			if (activeItemSlot >= 0):
				$Panel/ItemList.select(activeItemSlot, true)
				if (isDraggingItem or mouseButtonReleased):
					return
				if (!$Panel/ItemList.is_item_selectable(activeItemSlot)):
					end_drag_item()
					pass
				if (initial_mousePos.distance_to(get_viewport().get_mouse_position()) > 0.0):
					begin_drag_item(activeItemSlot)
					pass
		else:
			activeItemSlot = -1

func load_items() -> void:
	$Panel/ItemList.clear()
	for slot in range(0, 40):
		$Panel/ItemList.add_item("", null, false)
		update_slot(slot)

func update_slot(slot:int) -> void:
	if (slot < 0):
		return
		
	var inventoryItem:Dictionary = gamestate.state.inventory[str(slot)]
	var itemMetaData = DataParser.get_item(str(inventoryItem["id"])).duplicate()
	var icon = ResourceLoader.load(itemMetaData["icon"])
	var amount = int(inventoryItem["amount"])

	itemMetaData["amount"] = amount
	if (!itemMetaData["stackable"]):
		amount = " "
	$Panel/ItemList.set_item_text(slot, String(amount))
	$Panel/ItemList.set_item_icon(slot, icon)
	$Panel/ItemList.set_item_selectable(slot, int(inventoryItem["id"]) > 0)
	$Panel/ItemList.set_item_metadata(slot, itemMetaData)
	$Panel/ItemList.set_item_tooltip(slot, itemMetaData["name"])
	$Panel/ItemList.set_item_tooltip_enabled(slot, int(inventoryItem["id"]) > 0)
	
	if itemMetaData["type"] == "quest":
		$Panel/ItemList.set_item_custom_bg_color(slot, Color("#122864"))
	else:
		$Panel/ItemList.set_item_custom_bg_color(slot, Color("#000000"))

func begin_drag_item(index:int) -> void:
	if (isDraggingItem):
		return
	if (index < 0):
		return

	set_process(true)
	$Panel/Sprite_DraggedItem.texture = $Panel/ItemList.get_item_icon(index)
	$Panel/Sprite_DraggedItem.show()

	$Panel/ItemList.set_item_text(index, " ")
	$Panel/ItemList.set_item_icon(index, ResourceLoader.load(DataParser.get_item("0")["icon"]))

	draggedItemSlot = index
	isDraggingItem = true
	mouseButtonReleased = false
	$Panel/Sprite_DraggedItem.global_translate(get_viewport().get_mouse_position())
	pass
	
func move_merge_item():
	if (draggedItemSlot < 0):
		return
	if (activeItemSlot < 0):
		update_slot(draggedItemSlot)
		return

	if (activeItemSlot == draggedItemSlot):
		update_slot(draggedItemSlot)
	else:
		if ($Panel/ItemList.get_item_metadata(activeItemSlot)["id"] == $Panel/ItemList.get_item_metadata(draggedItemSlot)["id"]):
			var itemData = $Panel/ItemList.get_item_metadata(activeItemSlot)
			if (int(itemData["stack_limit"]) >= 2):
				DataParser.inventory_mergeItem(draggedItemSlot, activeItemSlot)
				update_slot(draggedItemSlot)
				update_slot(activeItemSlot)
				return
			else:
				update_slot(draggedItemSlot)
				return
		else:
			DataParser.inventory_moveItem(draggedItemSlot, activeItemSlot)
			update_slot(draggedItemSlot)
			update_slot(activeItemSlot)

	
func end_drag_item() -> void:
	set_process(false)
	draggedItemSlot = -1
	$Panel/Sprite_DraggedItem.hide()
	mouseButtonReleased = true
	isDraggingItem = false
	activeItemSlot = -1
	pass
	
# ----------------------------------------- my function ---------------------------------
func inventory_remove_all_item_quest() -> void:
	for slot in range(0, 40):
		var inventoryItem:Dictionary = gamestate.state.inventory[str(slot)]
		var itemMetaData = DataParser.get_item(str(inventoryItem["id"])).duplicate()
		
		if itemMetaData["type"] == "quest":
			gamestate.state.inventory[str(slot)] = {"amount":0,"id":"0"}
			update_slot(slot)

func initiate():
	load_items()
	
# ------------------------------ Signals -----------------------------------

#warning-ignore:unused_argument
func _on_ItemList_item_rmb_selected(index:int, atpos:Vector2):
	
	if (isDraggingItem):
		return
	if (isAwaitingSplit):
		return

	dropItemSlot = index
	var itemData:Dictionary = $Panel/ItemList.get_item_metadata(index)
	if (int(itemData["id"])) < 1: return
	var strItemInfo:String = ""

	$Panel/WindowDialog_ItemMenu.set_position(get_viewport().get_mouse_position())
	$Panel/WindowDialog_ItemMenu.set_title(itemData["name"])
	$Panel/WindowDialog_ItemMenu/ItemMenu_TextureFrame_Icon.set_texture($Panel/ItemList.get_item_icon(index))
	
	
	strItemInfo = "Name: [color=#00aedb] " + itemData["thai_name"] + "[/color]\n"
	strItemInfo = strItemInfo + "Type: [color=#f37735] " + itemData["type"] + "[/color]\n"
	strItemInfo = strItemInfo + "Weight: [color=#00b159] " + String(itemData["weight"]) + "[/color]\n"
	strItemInfo = strItemInfo + "Sell Price: [color=#ffc425] " + String(itemData["sell_price"]) + "[/color] gold\n"
	
	if itemData["type"] == "food" or itemData["type"] == "herb":
		strItemInfo = strItemInfo + "\n"
		strItemInfo = strItemInfo + "-------------------------------\n"
		if itemData["benefits"]["health"] != null:
			strItemInfo = strItemInfo + "เพิ่มเลือด : [color=#f37735]" + String(itemData["benefits"]["health"]) + "[/color]\n"
		if itemData["benefits"]["food"] != null:
			strItemInfo = strItemInfo + "เพิ่มอาหาร : [color=#f37735]" + String(itemData["benefits"]["food"]) + "[/color]\n"
		if itemData["benefits"]["water"] != null:
			strItemInfo = strItemInfo + "เพิ่มน้ำ : [color=#f37735]" + String(itemData["benefits"]["water"]) + "[/color]\n"
		strItemInfo = strItemInfo + "-------------------------------\n"
		
	strItemInfo = strItemInfo + "\n[color=#b3cde0]" + itemData["description"] + "[/color]"

	$Panel/WindowDialog_ItemMenu/ItemMenu_RichTextLabel_ItemInfo.set_bbcode(strItemInfo)
	$Panel/WindowDialog_ItemMenu/ItemMenu_Button_DropItem.set_text("(" + String(itemData["amount"]) + ") Drop" )
	$Panel/WindowDialog_ItemMenu/ItemMenu_Button_DropItem.show()
		
	if itemData["type"] == "quest":
		$Panel/WindowDialog_ItemMenu/ItemMenu_Button_DropItem.hide()
		
	if itemData["type"] == "herb" or itemData["type"] == "food":
		$Panel/WindowDialog_ItemMenu/ItemMenu_Button_Use.show()
	else:
		$Panel/WindowDialog_ItemMenu/ItemMenu_Button_Use.hide()
	
	activeItemSlot = index
	$Panel/WindowDialog_ItemMenu.popup()

func _on_ItemList_mouse_entered():
	cursor_insideItemList = true;


func _on_ItemList_mouse_exited():
	cursor_insideItemList = false;


func _on_close_button_pressed():
	if game.main == null: return
	game.gui.set_gui(1)


func _on_ItemMenu_Button_DropItem_pressed():
	var newAmount = DataParser.inventory_removeItem(dropItemSlot)
	if (newAmount < 1):
		$Panel/WindowDialog_ItemMenu.hide()
	else:
		$Panel/WindowDialog_ItemMenu/ItemMenu_Button_DropItem.set_text("(" + String(newAmount) + ") Drop")
	update_slot(dropItemSlot)
	game.text_alert.add_data_to_play("ทิ้งไอเทมสำเร็จแล้ว")


func _on_ItemMenu_Button_Use_pressed():
	# เพิ่ม เลือด อาหาร น้า บลาๆๆๆ
	var itemId = gamestate.state.inventory[String(dropItemSlot)]["id"]
	
	if itemId == "0": return
	
	if JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["food"] != null:
		gamestate.state.food += int(JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["food"])
		if gamestate.state.food >= 100:
			gamestate.state.food = 100

	if JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["water"] != null:
		gamestate.state.water += int(JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["water"])
		if gamestate.state.water >= 100:
			gamestate.state.water = 100
			
	if JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["health"] != null:
		gamestate.state.health += int(JsonGameMetaData.item_meta_data[String(itemId)]["benefits"]["health"])
		if gamestate.state.health >= 100:
			gamestate.state.health = 100
	
	var _newAmount = DataParser.inventory_removeItem(dropItemSlot)
	$Panel/WindowDialog_ItemMenu.hide()
	update_slot(dropItemSlot)
	
	game.hp_food_water_bar.update_bar()
	

	#print(JsonGameMetaData.item_meta_data[String(itemId)])
	
	
	game.text_alert.add_data_to_play("ใช้งานไอเทมสำเร็จแล้ว")
