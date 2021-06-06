extends Control


export var radius = 200
export var speed = 0.3

var num
var active = false

var is_working = false

var current_select = null

onready var gui = get_parent()
onready var open_gui_sound = get_node("open_gui_sound")

func _ready():
	game.b_menu = self
	
	show()
	$menu_buttons.hide()
	num = $menu_buttons.get_child_count()
	for b in $menu_buttons.get_children():
		b.rect_global_position = rect_global_position
	#connect("pressed", self, "_on_StartButton_pressed")
	
func show_menu():
	#print("showing")
	open_gui_sound.play()
	$menu_buttons.show()
	var spacing = TAU / num
	for b in $menu_buttons.get_children():
		#print(b.get_position_in_parent())
		var a = spacing * b.get_position_in_parent() - PI / 2
		var dest = b.rect_global_position + Vector2(radius, 0).rotated(a)
		$Tween.interpolate_property(b, "rect_global_position", rect_global_position,
				dest, speed, Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.interpolate_property(b, "rect_scale", Vector2(0.5, 0.5),
				Vector2.ONE, speed, Tween.TRANS_LINEAR)
		
		
	$Tween.start()
	get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
	get_parent().get_parent().get_node("blur_background").visible = true
	
func hide_menu():
	#print("hiding")
	open_gui_sound.play()
	for b in $menu_buttons.get_children():
		$Tween.interpolate_property(b, "rect_global_position", b.rect_global_position,
				rect_global_position, speed, Tween.TRANS_BACK, Tween.EASE_IN)
		$Tween.interpolate_property(b, "rect_scale", null,
				Vector2(0.5, 0.5), speed, Tween.TRANS_LINEAR)

	$Tween.start()
	get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
	get_parent().get_parent().get_node("blur_background").visible = false
	
"""
func _input(event):
	if event.is_action_pressed("b"):
		#disabled = true
		if !is_working:
			if active:
				hide_menu()
			else:
				show_menu()
			is_working = true
"""

func open_menu():
	if !is_working:
		is_working = true
		if active:
			hide_menu()
		else:
			show_menu()
		

func set_gui_state(s):
	gui.set_gui(s)
	current_select = null
	
func initiate():
	pass
	
func _on_Tween_tween_all_completed():
	#disabled = false
	is_working = false
	active = not active
	if not active:
		$menu_buttons.hide()
		if current_select != null:
			set_gui_state(current_select)

func _on_inventory_button_pressed():
	if !is_working:
		is_working = true
		#gui.set_gui(2)
		current_select = 2
		hide_menu()

func _on_quest_button_pressed():
	if !is_working:
		is_working = true
		#gui.set_gui(3)
		current_select = 3
		hide_menu()

func _on_perk_button_pressed():
	if !is_working:
		is_working = true
		#gui.set_gui(4)
		current_select = 4
		hide_menu()

func _on_manage_equ_button_pressed():
	if !is_working:
		is_working = true
		#gui.set_gui(5)
		current_select = 5
		hide_menu()
		


func _on_player_detail_pressed():
	if !is_working:
		is_working = true
		#gui.set_gui(5)
		current_select = 6
		hide_menu()
