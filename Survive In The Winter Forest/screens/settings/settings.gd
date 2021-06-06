extends CanvasLayer


const MENU_SCN = "res://screens/start_menu/start_menu.tscn"


func _ready():
	if game.main != null:
		
		$Panel/music_bg/music_volume.value = setting.setting_state.music_volume
		$Panel/sfx_bg/sfx_volume.value = setting.setting_state.sfx_volume
		
#		if setting.setting_state.music:
#			$Panel/music_bg/mute_music_button.text = "เปิด"
#		else:
#			$Panel/music_bg/mute_music_button.text = "ปิด"
#
#		if setting.setting_state.sfx:
#			$Panel/sfx_bg/mute_sfx_button.text = "เปิด"
#		else:
#			$Panel/sfx_bg/mute_sfx_button.text = "ปิด"
	
func _process(delta):
	var newMusicVolume = $Panel/music_bg/music_volume.value
	var newSFXVolume = $Panel/sfx_bg/sfx_volume.value
	
	if setting.setting_state.music_volume != newMusicVolume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), newMusicVolume)
		setting.setting_state.music_volume = newMusicVolume
		
	if setting.setting_state.sfx_volume != newSFXVolume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), newSFXVolume)
		setting.setting_state.sfx_volume = newSFXVolume

func _on_back_button_pressed():
	if game.main == null: return
	
	setting.save_settingstate()
	
	game.main.load_screen(MENU_SCN)
	


#func _on_mute_music_button_pressed():
#	if game.main != null:
#		if setting.setting_state.music:
#			AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
#			$Panel/music_bg/mute_music_button.text = "ปิด"
#			setting.setting_state.music = false
#		else:
#			AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
#			$Panel/music_bg/mute_music_button.text = "เปิด"
#			setting.setting_state.music = true
#		setting.save_settingstate()
#
#func _on_mute_sfx_button_pressed():
#	if game.main != null:
#		if setting.setting_state.sfx:
#			AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)
#			$Panel/sfx_bg/mute_sfx_button.text = "ปิด"
#			setting.setting_state.sfx = false
#		else:
#			AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
#			$Panel/sfx_bg/mute_sfx_button.text = "เปิด"
#			setting.setting_state.sfx = true
#		setting.save_settingstate()
