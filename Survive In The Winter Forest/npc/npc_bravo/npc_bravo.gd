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
	
	npc_name = name.split("_")[1]
	if npc_name != null:
		npc_type = JsonGameMetaData.npc[npc_name]["type"]
		
	for i in JsonGameMetaData.quest:
		if i == gamestate.state.quest["current_quest"]:
			if JsonGameMetaData.quest[gamestate.state.quest["current_quest"]]["npc_name"] == String(npc_name):
				is_current_quest = true
			#print(JsonGameMetaData.quest[gamestate.state.quest["current_quest"]])
	
	if is_current_quest:
		show_current_quest_emotion()
	
	var _Con1 = $player_detection.connect("body_entered", self, "_on_player_detection_body_entered")
	var _Con2 = $player_detection.connect("body_exited", self, "_on_player_detection_body_exited")
	set_process_input(false)
	
	$general_shop/player_detail/RichTextLabel.text = "money = " + str(gamestate.state.money)


func _input(_event):
	if Input.is_action_just_pressed("talk") and player_active and !dialog_active:
		
		dialog_active = true
		
		game.player.get_node("dialogue").initial_dialog(self)
		
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

func show_current_quest_emotion():
	$emotions_dialog/current_quest.show()
func hide_current_quest_emotion():
	$emotions_dialog/current_quest.hide()
	
func show_hint_talk():
	player_active = true
	set_process_input(true)
	$emotions_dialog/hint_talk.show()

func hide_hit_talk():
	player_active = false
	set_process_input(false)
	$emotions_dialog/hint_talk.hide()
	
	#$general_shop.hide()
	if game.main != null:
		game.shop.close_shop()
	
	close_npc()
	
func close_npc():
	dialog_active = false
	game.player.get_node("dialogue").close_dialog()


# ------------------------------- Open General Shop -------------------------
func show_general_shop():
	$emotions_dialog/hint_talk.hide()
	
	#$general_shop.show()
	if game.main != null:
		game.shop.initiate()
	

# ------------------------------- Signals -----------------------------------

func _on_player_detection_body_entered(body):
	if body.name == "player":
		show_hint_talk()
func _on_player_detection_body_exited(body):
	if body.name == "player":
		hide_hit_talk()
	check.mouse_on_gui = false
