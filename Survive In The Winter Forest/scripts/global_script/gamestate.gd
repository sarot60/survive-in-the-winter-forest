extends Node

signal gamestate_changed

var _fname := "gamestate.dat"
var state := {} setget _set_state
var saved_state := {} # backup if unable to save
var first_start := true

func _ready():
	print('my gamestate.gd')
	initiate()
	
#------------------------ set state ----------------------
func set_state( k, v, save_file := false ) -> bool:
	self.state[k] = v
	if save_file:
		return _save_gamestate()
	return true
func _set_state( v ):
	state = v
	emit_signal("gamestate_changed")
#---------------------------------------------------------


# Define initial game state
func initiate():
	state = _get_initial_gamestate()
	if game.debug:
		state = debug_gamestate
		pass
	saved_state = state.duplicate(true)

func _get_initial_gamestate():
	if game.debug:
			return debug_gamestate
	return {
		# true is mute
		# false in not mute
#		"music": false, 
#		"sfx": false, 
		
		"current_pos": [150, 300],
		"pet_current_pos": [250, 400],
		
		"money": 1653,
		"level": 1,
		"exp": 0,
		"perk_point": 0,
		
		# player status
		"health": 90,
		"food": 90,
		"water": 80,
		"sniper_damage": 100,
		"pistol_damage": 50,
		"knife_damage": 20, 
		"move_speed": 200,
		"animal_visible_range": 0,
		"reducation_food_rate": 1,
		"reducation_water_rate": 1,
		
		"day": 1,
		"max_survival_day": 1,
#		"time_seconds": 260,
		"time_seconds": 200,
		"sniper_ammo_current": 5,
		"sniper_mag": 4,
		"pistol_ammo_current": 12,
		"pistol_mag": 24,
		
		"deer_kill": 0,
		"rabbit_kill": 0,
		"wolf_kill": 0,
		"boss_wolf_kill": 0,
		
		"quest": {
			# เควสปัจจุบันคือใคร มี่ไรที่ต้องการ
			"current_quest": "001",
			# รับเควสแล้ว
			"accepted_quest": 0,
			# ทำเควสปัจจุบบันเสร็จแล้ว
			"success_current_quest": 0,
			"success_all": 0,
			# ที่ต้องการ
			"tmp_item_quest" : {
				#ตัวอย่าง
#				"913": 0,
#				"911": 0
			}
		},
		"perk": {
			"0": 0,
			"1": 0,
			"2": 0,
			"3": 0,
			"4": 0,
			"5": 0,
			"6": 0,
			"7": 0,
		},
		"camping": {
			"set_up_a_camp": 0,
			"camp_pos": []
		},
		"current_equipment": {
			"rifle": 1,
			"pistol": 1,
			"knife": 1,
			"binoculars": 1,
			"calling_device": 1,
			"shovel": 1
		},
		"herb_gps": {
			"mint_tree": 1,
			"rosemary_tree": 1,
			"parsley_tree": 1,
			"thyme_tree": 1,
			"winter_savory_tree": 1,
			"basil_tree": 1,
			"sage_tree": 1,
			"chives_tree": 1,
			"oregano_tree": 1,
			"catnip_tree": 1,
			"sorrel_tree": 1,
			"caraway_tree": 1,
			"tarragon_tree": 1,
			"horseradish_tree": 1
		},
		"inventory": {
			"0":{"amount":100,"id":"101"},
			"1":{"amount":1,"id":"102"},
			"2":{"amount":1,"id":"104"},
			"3":{"amount":100,"id":"103"},
			"4":{"amount":1,"id":"105"},
			"5":{"amount":14,"id":"504"},
			"6":{"amount":5,"id":"304"},
			"7":{"amount":0,"id":"0"},
			"8":{"amount":0,"id":"0"},
			"9":{"amount":0,"id":"0"},
			"10":{"amount":0,"id":"0"},
			"11":{"amount":0,"id":"0"},
			"12":{"amount":0,"id":"0"},
			"13":{"amount":0,"id":"0"},
			"14":{"amount":0,"id":"0"},
			"15":{"amount":0,"id":"0"},
			"16":{"amount":0,"id":"0"},
			"17":{"amount":0,"id":"0"},
			"18":{"amount":0,"id":"0"},
			"19":{"amount":0,"id":"0"},
			"20":{"amount":0,"id":"0"},
			"21":{"amount":0,"id":"0"},
			"22":{"amount":0,"id":"0"},
			"23":{"amount":0,"id":"0"},
			"24":{"amount":0,"id":"0"},
			"25":{"amount":0,"id":"0"},
			"26":{"amount":0,"id":"0"},
			"27":{"amount":0,"id":"0"},
			"28":{"amount":0,"id":"0"},
			"29":{"amount":0,"id":"0"},
			"30":{"amount":0,"id":"0"},
			"31":{"amount":0,"id":"0"},
			"32":{"amount":0,"id":"0"},
			"33":{"amount":0,"id":"0"},
			"34":{"amount":0,"id":"0"},
			"35":{"amount":0,"id":"0"},
			"36":{"amount":0,"id":"0"},
			"37":{"amount":0,"id":"0"},
			"38":{"amount":0,"id":"0"},
			"39":{"amount":0,"id":"0"},
		},
		"herb_tree": {
			"mint_tree": 1,
			"rosemary_tree": 1,
			"parsley_tree": 1,
			"thyme_tree": 1,
			"winter_savory_tree": 1,
			"basil_tree": 1,
			"sage_tree": 1,
			"chives_tree": 1,
			"oregano_tree": 1,
			"catnip_tree": 1,
			"sorrel_tree": 1,
			"caraway_tree": 1,
			"tarragon_tree": 1,
			"horseradish_tree": 1
		},
		"animal": {
			"rabbit_hole":{
				"1": 1,
				"2": 1,
				"3": 1,
				"4": 1,
				"5": 1,
				"6": 1,
				"7": 1,
				"8": 1,
				"9": 1,
				"10": 1,
				"11": 1,
				"12": 1,
				"13": 1,
				"14": 1,
				"15": 1,
				"16": 1,
				"17": 1,
				"18": 1,
				"19": 1,
				"20": 1
			},
			"moose": {
				"A1": 1,
				"A2": 1,
				"A3": 1,
				"A4": 1,
				"B1": 1,
				"B2": 1,
				"B3": 1,
				"B4": 1,
				"C1": 1,
				"C2": 1,
				"C3": 1,
				"C4": 1,
				"D1": 1,
				"D2": 1,
				"D3": 1,
				"D4": 1
			},
		}
	}

# save game state to file
func save_gamestate() -> bool:
	return _save_gamestate()
#func _save_gamestate() -> bool:
#	print( "SAVING GAMESTATE:" )
#	saved_state = state.duplicate( true )
##	return false
#	var f := File.new()
#	var err := f.open_encrypted_with_pass( \
#			_fname, File.WRITE, OS.get_unique_id() )
#	if err == OK:
#		f.store_var( state )
#		f.close()
#		return true
#	else:
#		f.close()
#		return false
func _save_gamestate() -> bool:
	print( "SAVING GAMESTATE:" )
	saved_state = state.duplicate( true )
#	return false
	var f := File.new()
	var err := f.open(_fname, File.WRITE)
	if err == OK:
		f.store_var( state )
		f.close()
		return true
	else:
		f.close()
		return false
		
# load game state from file
#func load_gamestate() -> bool:
#	var aux = _load_gamestate()
#	if aux.empty():
#		if game.debug: print( "gamestate: unable to load gamestate file" )
#		if not saved_state.empty():
#			if game.debug: print( "gamestate: using locally saved variable" )
#			state = saved_state.duplicate( true )
#		else:
#			if game.debug: print( "gamestate: using initial gamestate" )
#			state = _get_initial_gamestate()
#			saved_state = state.duplicate( true )
#		return false
#	state = aux
#	saved_state = state.duplicate( true )
#	first_start = false
#	return true
func load_gamestate() -> bool:
	var aux = _load_gamestate()
	state = aux
	saved_state = state.duplicate( true )
	first_start = false
	return true

#func _load_gamestate() -> Dictionary:
#	var f := File.new()
#	if not f.file_exists( _fname ):
#		return {}
#	var err = f.open_encrypted_with_pass( \
#			_fname, File.READ, OS.get_unique_id() )
#	if err != OK:
#		f.close()
#		return {}
#	var data = f.get_var()
#	f.close()
#	return data
func _load_gamestate() -> Dictionary:
	var f := File.new()
	if not f.file_exists( _fname ):
		return {}
	var err = f.open(_fname, File.READ)
	if err != OK:
		f.close()
		return {}
	var data = f.get_var()
	f.close()
	return data

func check_gamestate_file() -> bool:
	var tempstate = _load_gamestate()
	if tempstate.empty(): return false
	return true

func remove_gamestate_file() -> bool:
	var f := Directory.new()
	var err := f.remove(_fname)
	if err == OK:
		return true
	else:
		return false

# ---------- gather state and save game
func pre_state_and_save():
	
	if game.main == null: return
	if game.player == null: return
	
	gamestate.state.current_pos = [game.player.global_position.x, game.player.global_position.y]
	
	gamestate.state.pet_current_pos = [game.pet_dog.global_position.x, game.pet_dog.global_position.y]
	
	save_gamestate()

var debug_gamestate = { \
	"datetime" : 0, \
#	"events" : [], \
	"events" : [ "first dialog with wolf", "bitten" ], \
#	"events" : [ "first dialog with wolf", "bitten" ,"black chrystal"], \
#	"events" : ["green chrystal"], \
#		"events" : ["green chrystal","white chrystal"], \
#		"events" : ["green chrystal","white chrystal","red chrystal"], \
	"destructibles" : [], \
	"dead_robots": [], \
	"active_checkpoint": [ "", "" ], \
	"switches" : [], \
	"visited_stages" : [], \
#	"current_lvl" : "", \
#	"current_lvl" : "res://zones/mountain/stage_05.tscn", \
	"current_lvl" : "res://zones/forest/stage_14.tscn", \
#	"current_lvl" : "res://zones/cave/stage_04.tscn", \
#		"current_pos" : "finish_position", \
#		"current_pos" : "cutscene_position", \
	"current_pos" : "", \
	"current_dir" : 1, \
	"current_player_status" : "start", \
	"can_double_jump" : true, \
	"can_wall_jump" : true, \
	"can_attack" : true, \
	"can_push" : false, \
	"green_chrystal" : false, \
	"white_chrystal" : false, \
	"red_chrystal" : false, \
	"attack_reach" : 0.7, \
	"energy" : 3, \
	"max_energy" : 3 }


""" --------------------------------------------------------------------
							debug for testing
-------------------------------------------------------------------- """
