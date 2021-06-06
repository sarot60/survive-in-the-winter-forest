extends Control


onready var rifle_dialog = $change_rifle_dialog
onready var pistol_dialog = $change_pistol_dialog
onready var calling_device_dialog = $change_calling_device_dialog


func _ready():
	game.equ_gui = self

func initiate():
	
	var _rifle_texture = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["texture_interface"]
	$Panel/GridContainer/rifle/equ_background/TextureRect.texture = load(_rifle_texture)
	$Panel/GridContainer/rifle/name.text = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["name"]
	
	var _pistol_texture = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["texture_interface"]
	$Panel/GridContainer/pistol/equ_background/TextureRect.texture = load(_pistol_texture)
	$Panel/GridContainer/pistol/name.text = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["name"]
	
	var _knife_texture = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["texture"]
	$Panel/GridContainer/knife/equ_background/TextureRect.texture = load(_knife_texture)
	$Panel/GridContainer/knife/name.text = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["name"]
	
	var _binoculars_texture = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["texture"]
	$Panel/GridContainer/binoculars/equ_background/TextureRect.texture = load(_binoculars_texture)
	$Panel/GridContainer/binoculars/name.text = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["name"]
	
	var _calling_device_texture = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["texture"]
	$Panel/GridContainer/calling_device/equ_background/TextureRect.texture = load(_calling_device_texture)
	$Panel/GridContainer/calling_device/name.text = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["name"]
	
	var _shovel_texture = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["texture"]
	$Panel/GridContainer/shovel/equ_background/TextureRect.texture = load(_shovel_texture)
	$Panel/GridContainer/shovel/name.text = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["name"]

	rifle_dialog.initiate()
	pistol_dialog.initiate()
	#calling_device_dialog.initiate()

func update_rifle():
	var _rifle_texture = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["texture_interface"]
	$Panel/GridContainer/rifle/equ_background/TextureRect.texture = load(_rifle_texture)
	$Panel/GridContainer/rifle/name.text = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["name"]
	game.player.change_current_rifle()
	
func update_pistol():
	var _pistol_texture = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["texture_interface"]
	$Panel/GridContainer/pistol/equ_background/TextureRect.texture = load(_pistol_texture)
	$Panel/GridContainer/pistol/name.text = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["name"]
	
func update_knife():
	var _knife_texture = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["texture"]
	$Panel/GridContainer/knife/equ_background/TextureRect.texture = load(_knife_texture)
	$Panel/GridContainer/knife/name.text = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["name"]
	
func update_binoculars():
	var _binoculars_texture = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["texture"]
	$Panel/GridContainer/binoculars/equ_background/TextureRect.texture = load(_binoculars_texture)
	$Panel/GridContainer/binoculars/name.text = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["name"]
	
func update_calling_device():
	var _calling_device_texture = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["texture"]
	$Panel/GridContainer/calling_device/equ_background/TextureRect.texture = load(_calling_device_texture)
	$Panel/GridContainer/calling_device/name.text = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["name"]
	
func update_shovel():
	var _shovel_texture = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["texture"]
	$Panel/GridContainer/shovel/equ_background/TextureRect.texture = load(_shovel_texture)
	$Panel/GridContainer/shovel/name.text = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["name"]
	
	
func _on_close_button_pressed():
	if game.main == null: return
	game.gui.set_gui(1)


func _on_change_rifle_button_pressed():
	$change_rifle_dialog.popup()


func _on_change_pistol_button_pressed():
	$change_pistol_dialog.popup()


func _on_change_calling_device_button_pressed():
	#$change_calling_device_dialog.popup()
	pass
