extends Node

var _fname := "settingstate.dat"
var setting_state := {} setget _set_setting_state
var saved_setting_state := {} # backup if unable to save
var first_start = true

func _ready():
	print('my settingstate.gd')
	initiate()
	pass 

func set_setting_state( k, v, save_file := false ) -> bool:
	self.setting_state[k] = v
	if save_file:
		 return _save_setting_state()
	return true
	
func _set_setting_state( v ):
	setting_state = v

# Define initial setting state
func initiate():
	setting_state = _get_initial_settingstate()
	if game.debug:
		#setting_state = debug_gamestate
		pass
	saved_setting_state = setting_state.duplicate(true)
	
func _get_initial_settingstate():
	return {
		# true is mute
		# false in not mute / is playing
		"music": false, 
		"sfx": false, 
		
		"music_volume": 0,
		"sfx_volume": 0
	}
	
func save_settingstate() -> bool:
	return _save_setting_state()

func _save_setting_state() -> bool:
	print( "SAVING SETTINGSTATE:" )
	saved_setting_state = setting_state.duplicate( true )
#	return false
	var f := File.new()
	var err := f.open(_fname, File.WRITE)
	if err == OK:
		f.store_var( setting_state )
		f.close()
		return true
	else:
		f.close()
		return false
		
func load_settingstate() -> bool:
	var aux = _load_settingstate()
	setting_state = aux
	saved_setting_state = setting_state.duplicate( true )
	first_start = false
	return true

func _load_settingstate() -> Dictionary:
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

func check_settingstate_file() -> bool:
	var tempstate = _load_settingstate()
	if tempstate.empty(): return false
	return true
	
func remove_settingstate_file() -> bool:
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
	
	save_settingstate()
