extends Control

enum {
	RIFLE,
	PISTOL,
	KNIFE,
	BINOCULARS,
	CALLING_DEVICE,
	SHOVEL
}

var state = KNIFE
var prev_state = KNIFE

#onready var _x = preload("res://assets/equipment/rifle/rifle_1.png")
var _t = "res://assets/equipment/rifle/rifle_1.png"

func _ready():
	game.equ_hud = self
	add_to_group("update_equ_stats")
	
func update_hud():
	match prev_state:
		RIFLE:
			$background/rifle.visible = false
		PISTOL:
			$background/pistol.visible = false
		KNIFE:
			$background/knife.visible = false
		BINOCULARS:
			$background/binoculars.visible = false
		CALLING_DEVICE:
			$background/calling_device.visible = false
		SHOVEL:
			$background/shovel.visible = false
			
	match state:
		RIFLE:
			$background/rifle.visible = true
			$background/rifle/ammo.text = str(gamestate.state.sniper_ammo_current)+"/"+str(gamestate.state.sniper_mag)
		PISTOL:
			$background/pistol.visible = true
			$background/pistol/ammo.text = str(gamestate.state.pistol_ammo_current)+"/"+str(gamestate.state.pistol_mag)
		KNIFE:
			$background/knife.visible = true
		BINOCULARS:
			$background/binoculars.visible = true
		CALLING_DEVICE:
			$background/calling_device.visible = true
		SHOVEL:
			$background/shovel.visible = true
			
func update_equ_stats(p):
	state = p.equ_state
	update_hud()
	prev_state = state

func initiate():
	
	$background/rifle.visible = false
	$background/pistol.visible = false
	$background/knife.visible = false
	$background/binoculars.visible = false
	$background/calling_device.visible = false
	$background/shovel.visible = false
	
	var _rifle_texture = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["texture_interface"]
	$background/rifle/TextureRect.texture = load(_rifle_texture)
	
	var _pistol_texture = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["texture_interface"]
	$background/pistol/TextureRect.texture = load(_pistol_texture)
	
	var _knife_texture = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["texture"]
	$background/knife/TextureRect.texture = load(_knife_texture)
	
	var _binoculars_texture = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["texture"]
	$background/binoculars/TextureRect.texture = load(_binoculars_texture)
	
	var _calling_device_texture = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["texture"]
	$background/calling_device/TextureRect.texture = load(_calling_device_texture)
	
	var _shovel_texture = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["texture"]
	$background/shovel/TextureRect.texture = load(_shovel_texture)
	
	state = KNIFE
	prev_state = KNIFE
	
	update_hud()

func update_rifle_hud():
	var _rifle_texture = JsonGameMetaData.equipment["rifle"][str(gamestate.state.current_equipment.rifle)]["texture_interface"]
	$background/rifle/TextureRect.texture = load(_rifle_texture)

func update_pistol_hud():
	var _pistol_texture = JsonGameMetaData.equipment["pistol"][str(gamestate.state.current_equipment.pistol)]["texture_interface"]
	$background/pistol/TextureRect.texture = load(_pistol_texture)

func update_knife_hud():
	var _knife_texture = JsonGameMetaData.equipment["knife"][str(gamestate.state.current_equipment.knife)]["texture"]
	$background/knife/TextureRect.texture = load(_knife_texture)
	
func update_binoculars_hud():
	var _binoculars_texture = JsonGameMetaData.equipment["binoculars"][str(gamestate.state.current_equipment.binoculars)]["texture"]
	$background/binoculars/TextureRect.texture = load(_binoculars_texture)
	
func update_calling_device_hud():
	var _calling_device_texture = JsonGameMetaData.equipment["calling_device"][str(gamestate.state.current_equipment.calling_device)]["texture"]
	$background/calling_device/TextureRect.texture = load(_calling_device_texture)
	
func update_shovel_hud():
	var _shovel_texture = JsonGameMetaData.equipment["shovel"][str(gamestate.state.current_equipment.shovel)]["texture"]
	$background/shovel/TextureRect.texture = load(_shovel_texture)
