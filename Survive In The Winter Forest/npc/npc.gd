extends Node

# gdscrip module
var rng = RandomNumberGenerator.new()

var player_active = false
var dialog_active = false

const breath_eff = preload("res://effects/breath/breath.tscn")

var npc_name = null
var npc_type = null
var is_current_quest = false
var current_quest = null

func _ready():
	
	add_to_group("check_current_quest_success")
	
	npc_name = name.split("_")[1]
	
	switch_quest_status(null)
	
	var _tmp1 = $player_detection.connect("body_entered", self, "_on_player_detect_body_entered")
	var _tmp2 = $player_detection.connect("body_exited", self, "_on_player_detect_body_exited")
	
	set_process_input(false)

func initiate():
	pass

var i = 0
var ran_breath = 1.5
func _process(delta):
	
	if has_node("graphics/breath_position"):
		i += delta
		if i > ran_breath:
			breath()
			i = 0
	else:
		set_process(false)
	
func breath():
	rng.randomize()
	ran_breath = rng.randf_range(1.5, 2.5)
	var breath_obj = breath_eff.instance()
	breath_obj.global_position = $graphics/breath_position.global_position
	get_tree().get_root().add_child(breath_obj)
	breath_obj.emitting = true

func switch_quest_status(_s) -> void:
	if npc_name != null:
		npc_type = JsonGameMetaData.npc[npc_name]["type"]
	
	#print('switch')
	
	for i in JsonGameMetaData.quest:
		if i == gamestate.state.quest["current_quest"]:
			if JsonGameMetaData.quest[gamestate.state.quest["current_quest"]]["npc_name"] == String(npc_name):
				is_current_quest = true
				current_quest = gamestate.state.quest["current_quest"]
			else:
				is_current_quest = false
			#print(JsonGameMetaData.quest[gamestate.state.quest["current_quest"]])
			
	if gamestate.state.quest.success_all == 1:
		is_current_quest = false
		hide_current_quest_emotion()
		return
	
	if is_current_quest:
		show_current_quest_emotion()
	else:
		hide_current_quest_emotion()
	
	return
		
func _input(_event):
	if Input.is_action_just_pressed("talk") and player_active and !dialog_active:
		
		dialog_active = true
		
		game.player.get_node("dialogue").initial_dialog(self)

func show_current_quest_emotion():
	if gamestate.state.quest.success_current_quest == 1:
		$emotions_dialog/success_quest.show()
		$emotions_dialog/current_quest.hide()
		return
	elif gamestate.state.quest.accepted_quest == 1:
		$emotions_dialog/current_quest.set_self_modulate(Color( 0.4, 0.4, 0.4, 1 ))
	elif gamestate.state.quest.accepted_quest == 0:
		$emotions_dialog/current_quest.set_self_modulate(Color( 1, 1, 1, 1 ))
		
	$emotions_dialog/current_quest.show()
	
	$emotions_dialog/success_quest.hide()
	
func hide_current_quest_emotion():
	$emotions_dialog/current_quest.hide()
	
	$emotions_dialog/success_quest.hide()
	
	
func show_hint_talk():
	player_active = true
	set_process_input(true)
	$emotions_dialog/hint_talk.show()
	
func hide_hit_talk():
	set_process_input(false)
	$emotions_dialog/hint_talk.hide()
	player_active = false
	
	close_npc()
	
func close_npc():
	dialog_active = false
	
	game.player.get_node("dialogue").close_dialog()
	
	if is_current_quest:
		show_current_quest_emotion()

# -------------------------- Signals ---------------------------------------

func _on_player_detect_body_entered(body):
	if body.name == "player":
		show_hint_talk()
		
func _on_player_detect_body_exited(body):
	if body.name == "player":
		hide_hit_talk()
		
		check.mouse_on_gui = false
		
