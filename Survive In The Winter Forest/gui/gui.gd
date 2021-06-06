extends Control

enum {
	NULL
	B_MENU,
	INVENTORY,
	QUEST,
	PERK,
	MANAGE_EQU,
	PLAYER_DETAIL
}

var gui_state = NULL
var prev_gui_state = NULL

# gui
onready var b_menu = get_node("B_menu")
onready var inventory = get_node("inventory")
onready var perk = get_node("perk")
onready var manage_equ = get_node("manage_equipment")
onready var quest = get_node("quest")
onready var player_detail = get_node("player_detail")

onready var blur_background = get_parent().get_node("blur_background")


func _ready():
	game.gui = self
	
func _input(event):
	if event.is_action_pressed("b") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(1)
	
	# inventory
	elif event.is_action_pressed("i") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
			set_gui(2)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(2)
	
	# player status
	elif event.is_action_pressed("p") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
			set_gui(6)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(6)
		
	# quest
	elif event.is_action_pressed("l") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
			set_gui(3)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(3)
		
	# prek or skill
	elif event.is_action_pressed("k") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
			set_gui(4)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(4)
		
	# manage equ
	elif event.is_action_pressed("u") and !b_menu.is_working:
		if b_menu.active:
			hide()
			game.herb_tree_marker.hide()
			set_gui(0)
			set_gui(5)
		else:
			show()
			game.herb_tree_marker.hide()
			set_gui(5)
		
		
func set_gui(t):
	gui_state = t
	update_gui()
	prev_gui_state = gui_state

func update_gui():
	if gui_state != NULL:
		match prev_gui_state:
			INVENTORY:
				gui_state = NULL
				prev_gui_state = NULL
				inventory.hide()
				get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
				blur_background.visible = false
				b_menu.open_gui_sound.play()
				hide()
				return
			QUEST:
				gui_state = NULL
				prev_gui_state = NULL
				quest.hide()
				get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
				blur_background.visible = false
				b_menu.open_gui_sound.play()
				hide()
				return
			PERK:
				gui_state = NULL
				prev_gui_state = NULL
				perk.hide()
				get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
				blur_background.visible = false
				b_menu.open_gui_sound.play()
				hide()
				return
			MANAGE_EQU:
				gui_state = NULL
				prev_gui_state = NULL
				manage_equ.hide()
				get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
				blur_background.visible = false
				b_menu.open_gui_sound.play()
				hide()
				return
			PLAYER_DETAIL:
				gui_state = NULL
				prev_gui_state = NULL
				player_detail.hide()
				get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
				blur_background.visible = false
				b_menu.open_gui_sound.play()
				hide()
				return
				
	# hide b menu
	if b_menu.active and gui_state == NULL:
		b_menu.open_menu()
		hide()
		return
	# show b menu
	elif !b_menu.active and gui_state == B_MENU:
		b_menu.open_menu()
		show()
		return
		
	match gui_state:
		INVENTORY:
			prev_gui_state = NULL
			show()
			inventory.show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			blur_background.visible = true
			
		QUEST:
			prev_gui_state = NULL
			show()
			quest.show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			blur_background.visible = true
			
			game.quest.update_gui()
			
		PERK:
			prev_gui_state = NULL
			show()
			perk.show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			blur_background.visible = true
			
			game.perk.update_gui()
			
		MANAGE_EQU:
			prev_gui_state = NULL
			show()
			manage_equ.show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			blur_background.visible = true
			
			game.equ_gui.get_node("change_rifle_dialog").unlock_rifle()
			game.equ_gui.get_node("change_pistol_dialog").unlock_pistol()
			
		PLAYER_DETAIL:
			prev_gui_state = NULL
			show()
			player_detail.show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			blur_background.visible = true
			
			game.player_detail.update_gui()
			
func initiate():
	hide()
	set_gui(0)
	inventory.hide()
	quest.hide()
	perk.hide()
	manage_equ.hide()
	player_detail.hide()
	blur_background.visible = false
	
