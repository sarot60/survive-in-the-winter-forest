extends Node

const GAMESTATE_FILE = "gamedata.dat"

# player
var player = null setget _set_player, _get_player
var pet_dog = null setget _set_pet_dog, _get_pet_dog

# gui
var gui = null setget _set_gui, _get_gui
var b_menu = null setget _set_b_menu, _get_b_menu
var inventory = null setget _set_inventory, _get_inventory
var equ_gui = null setget _set_equ_gui, _get_equ_gui
var player_detail = null setget _set_player_detail, _get_player_detail
var quest = null setget _set_quest, _get_quest
var perk = null setget _set_perk, _get_perk

var herb_tree_marker = null setget _set_herb_tree_marker, _get_herb_tree_marker
var shop = null setget _set_shop, _get_shop

# hud
var hud = null setget _set_hud, _get_hud
var clock = null setget _set_clock, _get_clock
var hp_food_water_bar = null setget _set_hp_food_water_bar, _get_hp_food_water_bar
var equ_hud = null setget _set_equ_hud, _get_equ_hud
var text_alert = null setget _set_text_alert, _get_text_alert
var reward_alert = null setget _set_reward_alert, _get_reward_alert

var main_map = null setget _set_main_map, _get_main_map

# warning-ignore:unused_class_variable
var main = null

# warning-ignore:unused_class_variable
var debug = false

func _ready():
	self.pause_mode = PAUSE_MODE_PROCESS
	print('my game.gd')

#-------------------- set player ---------------------
func _set_player(v):
	player = weakref(v)
func _get_player():
	if player == null: return null
	return player.get_ref()
#-----------------------------------------------------
#-------------------- set pet ------------------------
func _set_pet_dog(v):
	pet_dog = weakref(v)
func _get_pet_dog():
	if pet_dog == null: return null
	return pet_dog.get_ref()
#-------------------------------------------------------

# ================================= HUD ===============================
#-------------------- set hud -----------------
func _set_hud(v):
	hud = weakref(v)
func _get_hud():
	if hud == null: return null
	return hud.get_ref()
#-------------------------------------------------
#-------------------- set clock -----------------
func _set_clock(v):
	clock = weakref(v)
func _get_clock():
	if clock == null: return null
	return clock.get_ref()
#-------------------------------------------------
#-------------------- set health bar -----------------
func _set_hp_food_water_bar(v):
	hp_food_water_bar = weakref(v)
func _get_hp_food_water_bar():
	if hp_food_water_bar == null: return null
	return hp_food_water_bar.get_ref()
#-------------------------------------------------
#-------------------- set equipment hud -----------------
func _set_equ_hud(v):
	equ_hud = weakref(v)
func _get_equ_hud():
	if equ_hud == null: return null
	return equ_hud.get_ref()
#-------------------------------------------------
#-------------------- set text alert hud -----------------
func _set_text_alert(v):
	text_alert = weakref(v)
func _get_text_alert():
	if text_alert == null: return null
	return text_alert.get_ref()
#-------------------------------------------------
#-------------------- set reward alert hud -----------------
func _set_reward_alert(v):
	reward_alert = weakref(v)
func _get_reward_alert():
	if reward_alert == null: return null
	return reward_alert.get_ref()
#-------------------------------------------------
	
# ================================= GUI ===============================
#-------------------- set gui -----------------
func _set_gui(v):
	gui = weakref(v)
func _get_gui():
	if gui == null: return null
	return gui.get_ref()
#-------------------------------------------------
#-------------------- set B menu -----------------
func _set_b_menu(v):
	b_menu = weakref(v)
func _get_b_menu():
	if b_menu == null: return null
	return b_menu.get_ref()
#-------------------------------------------------
#-------------------- set inventory -----------------
func _set_inventory(v):
	inventory = weakref(v)
func _get_inventory():
	if inventory == null: return null
	return inventory.get_ref()
#-------------------------------------------------
#-------------------- set equipment gui -----------------
func _set_equ_gui(v):
	equ_gui = weakref(v)
func _get_equ_gui():
	if equ_gui == null: return null
	return equ_gui.get_ref()
#-------------------------------------------------
#-------------------- set perk gui -----------------
func _set_perk(v):
	perk = weakref(v)
func _get_perk():
	if perk == null: return null
	return perk.get_ref()
#-------------------------------------------------
#-------------------- set quest gui -----------------
func _set_quest(v):
	quest = weakref(v)
func _get_quest():
	if quest == null: return null
	return quest.get_ref()
#-------------------------------------------------
#-------------------- set player detail gui -----------------
func _set_player_detail(v):
	player_detail = weakref(v)
func _get_player_detail():
	if player_detail == null: return null
	return player_detail.get_ref()
#-------------------------------------------------

#-------------------- set herb tree marker -----------------
func _set_herb_tree_marker(v):
	herb_tree_marker = weakref(v)
func _get_herb_tree_marker():
	if herb_tree_marker == null: return null
	return herb_tree_marker.get_ref()
#-------------------------------------------------
#-------------------- set shop -----------------
func _set_shop(v):
	shop = weakref(v)
func _get_shop():
	if shop == null: return null
	return shop.get_ref()
#-------------------------------------------------

#func _process(_delta):
	#print(_get_player().health)
#	pass

#-------------------- set main map -----------------
func _set_main_map(v):
	main_map = weakref(v)
func _get_main_map():
	if main_map == null: return null
	return main_map.get_ref()
	
#---------------------------------------------------

""" --------------------------------------------------------------------
								success
-------------------------------------------------------------------- """

#----------------------- full screen ------------------------
var is_fullscreen = false
var window_size = Vector2.ZERO
var window_pos = Vector2.ZERO
func _input(_event):
	if Input.is_action_just_pressed("btn_fullscreen"):
		if not is_fullscreen:
			OS.set_borderless_window(true)
			window_size = OS.window_size
			OS.window_size = OS.get_screen_size()
			window_pos = OS.window_position
			OS.window_position = Vector2.ZERO
			#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			is_fullscreen = true
		else:
			OS.set_borderless_window(false)
			OS.window_size = window_size
			OS.window_position = window_pos
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			is_fullscreen = false
#--------------------- end full screen ----------------------
