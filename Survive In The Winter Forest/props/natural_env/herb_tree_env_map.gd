extends YSort

var herb_tree_position = {
	"mint_tree": [-2600, -2400],
	"rosemary_tree": [650, -8700],
	"parsley_tree": [7360, -3960],
	"thyme_tree": [-8300, 6100],
	"winter_savory_tree": [4160, 5440],
	"basil_tree": [-6700, -2900],
	"sage_tree": [8140, -8480],
	"chives_tree": [-8520, -7500],
	"oregano_tree": [7460, 8030],
	"catnip_tree": [-2130, -8140],
	"sorrel_tree": [-4900, 2310],
	"caraway_tree": [5650, 1770],
	"tarragon_tree": [-2615, 5980],
	"horseradish_tree": [3220, -3510]
}

const herb_item = {
	"mint_tree": 301,
	"rosemary_tree": 302,
	"parsley_tree": 303,
	"thyme_tree": 304,
	"winter_savory_tree": 305,
	"basil_tree": 306,
	"sage_tree": 307,
	"chives_tree": 308,
	"oregano_tree": 309,
	"catnip_tree": 310,
	"sorrel_tree": 311,
	"caraway_tree": 312,
	"tarragon_tree": 313,
	"horseradish_tree": 314
}

const mint_tree = preload("res://props/herb_tree/mint_tree.tscn")
const rosemary_tree = preload("res://props/herb_tree/rosemary_tree.tscn")
const parsley_tree = preload("res://props/herb_tree/parsley_tree.tscn")
const thyme_tree = preload("res://props/herb_tree/thyme_tree.tscn")
const winter_savory_tree = preload("res://props/herb_tree/winter_savory_tree.tscn")
const basil_tree = preload("res://props/herb_tree/basil_tree.tscn")
const sage_tree = preload("res://props/herb_tree/sage_tree.tscn")
const chives_tree = preload("res://props/herb_tree/chives_tree.tscn")
const oregano_tree = preload("res://props/herb_tree/oregano_tree.tscn")
const catnip_tree = preload("res://props/herb_tree/catnip_tree.tscn")
const sorrel_tree = preload("res://props/herb_tree/sorrel_tree.tscn")
const caraway_tree = preload("res://props/herb_tree/caraway_tree.tscn")
const tarragon_tree = preload("res://props/herb_tree/tarragon_tree.tscn")
const horseradish_tree = preload("res://props/herb_tree/horseradish_tree.tscn")

const off_screen_herb_tree = preload("res://props/herb_tree/off_screen_herb_tree.tscn")
const herb_tree_marker = preload("res://props/herb_tree/herb_tree_marker.tscn")

func _ready():
	
	add_to_group("make_herb_tree_maker")
	add_to_group("delete_herb_tree_marker")
	
	for i in gamestate.state.herb_tree:
		if i == "mint_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_mint()
			else:
				reload_mint()
			
		if i == "rosemary_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_rosemary()
			else:
				reload_rosemary()

		if i == "parsley_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_parsley()
			else:
				reload_parsley()
				
		if i == "thyme_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_thyme()
			else:
				reload_thyme()
		
		if i == "winter_savory_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_winter_savory()
			else:
				reload_winter_savory()
			
		if i == "basil_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_basil()
			else:
				reload_basil()
				
		if i == "sage_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_sage()
			else:
				reload_sage()
				
		if i == "chives_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_chives()
			else:
				reload_chives()
				
		if i == "oregano_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_oregano()
			else:
				reload_oregano()
				
		if i == "catnip_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_catnip()
			else:
				reload_catnip()
				
		if i == "sorrel_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_sorrel()
			else:
				reload_sorrel()
				
		if i == "caraway_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_caraway()
			else:
				reload_caraway()
		
		if i == "tarragon_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_tarragon()
			else:
				reload_tarragon()
				
		if i == "horseradish_tree":
			if gamestate.state.herb_tree[i] == 1:
				make_horseradish()
			else:
				reload_horseradish()
		
	#make_herb_tree_maker("oregano_tree")

func delete_herb_tree_marker(_b:bool):
	if get_node("herb_tree_marker").get_child_count() > 0:
		for i in get_node("herb_tree_marker").get_children():
			i.queue_free()

func make_herb_tree_maker(herb_tree_name:String):
	
	delete_herb_tree_marker(true)
	
	var herb_tree_marker_obj = herb_tree_marker.instance()
	herb_tree_marker_obj.global_position = Vector2(herb_tree_position[herb_tree_name][0], herb_tree_position[herb_tree_name][1] - 64)
	herb_tree_marker_obj.get_node("icon/herb_texture").texture = load(JsonGameMetaData.item_meta_data[str(herb_item[herb_tree_name])].icon)
	get_node("herb_tree_marker").add_child(herb_tree_marker_obj)
	
	var off_screen_herb_tree_obj = off_screen_herb_tree.instance()
	off_screen_herb_tree_obj.global_position = Vector2(herb_tree_position[herb_tree_name][0], herb_tree_position[herb_tree_name][1])
	off_screen_herb_tree_obj.get_node("Sprite/icon/herb_texture").texture = load(JsonGameMetaData.item_meta_data[str(herb_item[herb_tree_name])].icon)
	get_node("herb_tree_marker").add_child(off_screen_herb_tree_obj)
	off_screen_herb_tree_obj.show()
	off_screen_herb_tree_obj.set_physics_process(true)

func make_mint():
	var mint_tree_obj = mint_tree.instance()
	
	mint_tree_obj.global_position = Vector2(herb_tree_position[mint_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[mint_tree_obj.name.split("[")[0]][1])
	
	add_child(mint_tree_obj)
	
	gamestate.state.herb_tree["mint_tree"] = 1
func reload_mint():
	$mint_tree_timer.set_wait_time(30)
	$mint_tree_timer.start()


func make_rosemary():
	var rosemary_tree_obj = rosemary_tree.instance()
	
	rosemary_tree_obj.global_position = Vector2(herb_tree_position[rosemary_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[rosemary_tree_obj.name.split("[")[0]][1])
	
	add_child(rosemary_tree_obj)
	
	gamestate.state.herb_tree["rosemary_tree"] = 1
func reload_rosemary():
	$rosemary_tree_timer.set_wait_time(30)
	$rosemary_tree_timer.start()
	
func make_parsley():
	var parsley_tree_obj = parsley_tree.instance()
	
	parsley_tree_obj.global_position = Vector2(herb_tree_position[parsley_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[parsley_tree_obj.name.split("[")[0]][1])
	
	add_child(parsley_tree_obj)
	
	gamestate.state.herb_tree["parsley_tree"] = 1
func reload_parsley():
	$parsley_tree_timer.set_wait_time(30)
	$parsley_tree_timer.start()
	
func make_thyme():
	var thyme_tree_obj = thyme_tree.instance()
	
	thyme_tree_obj.global_position = Vector2(herb_tree_position[thyme_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[thyme_tree_obj.name.split("[")[0]][1])
	
	add_child(thyme_tree_obj)
func reload_thyme():
	$thyme_tree_timer.set_wait_time(30)
	$thyme_tree_timer.start()
	
func make_winter_savory():
	var winter_savory_tree_obj = winter_savory_tree.instance()
	
	winter_savory_tree_obj.global_position = Vector2(herb_tree_position[winter_savory_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[winter_savory_tree_obj.name.split("[")[0]][1])
	
	add_child(winter_savory_tree_obj)
	
	gamestate.state.herb_tree["winter_savory_tree"] = 1
func reload_winter_savory():
	$winter_savory_tree_timer.set_wait_time(30)
	$winter_savory_tree_timer.start()

func make_basil():
	var basil_tree_obj = basil_tree.instance()
	
	basil_tree_obj.global_position = Vector2(herb_tree_position[basil_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[basil_tree_obj.name.split("[")[0]][1])
	
	add_child(basil_tree_obj)
	
	gamestate.state.herb_tree["basil_tree"] = 1
func reload_basil():
	$basil_tree_timer.set_wait_time(30)
	$basil_tree_timer.start()

func make_sage():
	var sage_tree_obj = sage_tree.instance()
	
	sage_tree_obj.global_position = Vector2(herb_tree_position[sage_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[sage_tree_obj.name.split("[")[0]][1])
	
	add_child(sage_tree_obj)
	
	gamestate.state.herb_tree["sage_tree"] = 1
func reload_sage():
	$sage_tree_timer.set_wait_time(30)
	$sage_tree_timer.start()
	
func make_chives():
	var chives_tree_obj = chives_tree.instance()
	
	chives_tree_obj.global_position = Vector2(herb_tree_position[chives_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[chives_tree_obj.name.split("[")[0]][1])
	
	add_child(chives_tree_obj)
	
	gamestate.state.herb_tree["chives_tree"] = 1
func reload_chives():
	$chives_tree_timer.set_wait_time(30)
	$chives_tree_timer.start()
	
func make_oregano():
	var oregano_tree_obj = oregano_tree.instance()
	
	oregano_tree_obj.global_position = Vector2(herb_tree_position[oregano_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[oregano_tree_obj.name.split("[")[0]][1])
	
	add_child(oregano_tree_obj)
	
	gamestate.state.herb_tree["oregano_tree"] = 1
func reload_oregano():
	$oregano_tree_timer.set_wait_time(30)
	$oregano_tree_timer.start()
	
func make_catnip():
	var catnip_tree_obj = catnip_tree.instance()
	
	catnip_tree_obj.global_position = Vector2(herb_tree_position[catnip_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[catnip_tree_obj.name.split("[")[0]][1])
	
	add_child(catnip_tree_obj)
	
	gamestate.state.herb_tree["catnip_tree"] = 1
func reload_catnip():
	$catnip_tree_timer.set_wait_time(30)
	$catnip_tree_timer.start()
	
func make_sorrel():
	var sorrel_tree_obj = sorrel_tree.instance()
	
	sorrel_tree_obj.global_position = Vector2(herb_tree_position[sorrel_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[sorrel_tree_obj.name.split("[")[0]][1])
	
	add_child(sorrel_tree_obj)
	
	gamestate.state.herb_tree["sorrel_tree"] = 1
func reload_sorrel():
	$sorrel_tree_timer.set_wait_time(30)
	$sorrel_tree_timer.start()
	
func make_caraway():
	var caraway_tree_obj = caraway_tree.instance()
	
	caraway_tree_obj.global_position = Vector2(herb_tree_position[caraway_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[caraway_tree_obj.name.split("[")[0]][1])
	
	add_child(caraway_tree_obj)
	
	gamestate.state.herb_tree["caraway_tree"] = 1
func reload_caraway():
	$caraway_tree_timer.set_wait_time(30)
	$caraway_tree_timer.start()
	
func make_tarragon():
	var tarragon_tree_obj = tarragon_tree.instance()
	
	tarragon_tree_obj.global_position = Vector2(herb_tree_position[tarragon_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[tarragon_tree_obj.name.split("[")[0]][1])
	
	add_child(tarragon_tree_obj)
	
	gamestate.state.herb_tree["tarragon_tree"] = 1
func reload_tarragon():
	$tarragon_tree_timer.set_wait_time(30)
	$tarragon_tree_timer.start()
	
func make_horseradish():
	var horseradish_tree_obj = horseradish_tree.instance()
	
	horseradish_tree_obj.global_position = Vector2(herb_tree_position[horseradish_tree_obj.name.split("[")[0]][0], \
	herb_tree_position[horseradish_tree_obj.name.split("[")[0]][1])
	
	add_child(horseradish_tree_obj)
	
	gamestate.state.herb_tree["horseadish_tree"] = 1
func reload_horseradish():
	$horseradish_timer.set_wait_time(30)
	$horseradish_timer.start()


# -------------------------------------- Signals ----------------------------

func _on_mint_tree_timer_timeout():
	make_mint()


func _on_rosemary_tree_timer_timeout():
	make_rosemary()


func _on_parsley_tree_timer_timeout():
	make_parsley()


func _on_thyme_tree_timer_timeout():
	make_thyme()


func _on_winter_savory_tree_timer_timeout():
	make_winter_savory()


func _on_basil_tree_timer_timeout():
	make_basil()


func _on_sage_tree_timer_timeout():
	make_sage()


func _on_chives_tree_timer_timeout():
	make_chives()


func _on_oregano_tree_timer_timeout():
	make_oregano()


func _on_catnip_tree_timer_timeout():
	make_catnip()


func _on_sorrel_tree_timer_timeout():
	make_sorrel()


func _on_caraway_tree_timer_timeout():
	make_caraway()


func _on_tarragon_tree_timer_timeout():
	make_tarragon()


func _on_horseradish_timer_timeout():
	make_horseradish()
