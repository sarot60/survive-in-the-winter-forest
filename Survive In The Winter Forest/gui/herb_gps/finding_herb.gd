extends Control

var herb_gps_open = false

func _ready():
	game.herb_tree_marker = self
	
func _input(event):
	if event.is_action_pressed("g_menu") and game.gui.gui_state == 0:
		if !herb_gps_open:
			show()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", true)
			herb_gps_open = true
		else:
			hide()
			get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
			herb_gps_open = false

func find_herb_tree(herb_tree_name:String):
	get_tree().call_group("make_herb_tree_maker", "make_herb_tree_maker" , herb_tree_name)
	get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
	herb_gps_open = false
	hide()

# 1
func _on_find_mint_tree_pressed():
	find_herb_tree("mint_tree")

# 2
func _on_find_rosemary_tree_pressed():
	find_herb_tree("rosemary_tree")

# 3
func _on_find_parsley_tree_pressed():
	find_herb_tree("parsley_tree")

# 4
func _on_find_thyme_tree_pressed():
	find_herb_tree("thyme_tree")

# 5
func _on_find_winter_savory_tree_pressed():
	find_herb_tree("winter_savory_tree")

#6
func _on_find_basil_tree_pressed():
	find_herb_tree("basil_tree")

# 7
func _on_find_sage_tree_pressed():
	find_herb_tree("sage_tree")

# 8
func _on_find_chives_tree_pressed():
	find_herb_tree("chives_tree")

# 9
func _on_find_oregano_tree_pressed():
	find_herb_tree("oregano_tree")

# 10
func _on_find_catnip_tree_pressed():
	find_herb_tree("catnip_tree")

# 11
func _on_find_sorrel_tree_pressed():
	find_herb_tree("sorrel_tree")

# 12
func _on_find_caraway_tree_pressed():
	find_herb_tree("caraway_tree")

# 13
func _on_find_tarragon_tree_pressed():
	find_herb_tree("tarragon_tree")

# 14
func _on_find_horseradish_tree_pressed():
	find_herb_tree("horseradish_tree")


func _on_close_button_pressed():
	hide()
	herb_gps_open = false
	get_tree().call_group("update_menu_is_open", "update_menu_is_open", false)
