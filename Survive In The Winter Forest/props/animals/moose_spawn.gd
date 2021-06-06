extends YSort

# gdscrip module
var rng = RandomNumberGenerator.new()

const moose = preload("res://props/animals/moose/moose.tscn")

var spawn_name = null

var deer_random_spawn = {
	# - , -
	"A1": [-2000, -2000],
	"A2": [-2000, -7000],
	"A3": [-7000, -7000],
	"A4": [-7000, -2000],
	
	# + , -
	"B1": [2000, -2000],
	"B2": [2000, -7000],
	"B3": [7000, -7000],
	"B4": [7000, -2000],
	
	# - , +
	"C1": [-2000, 2000],
	"C2": [-2000, 7000],
	"C3": [-7000, 7000],
	"C4": [-7000, 2000],
	
	# + , +
	"D1": [2000, 2000],
	"D2": [2000, 7000],
	"D3": [7000, 7000],
	"D4": [7000, 2000],
}

func _ready():
	spawn_name = name
	
	var _tmpConnect = get_node("moose_reload").connect("timeout", self, "_on_moose_reload_timeout")
	
	add_to_group("reload_moose")
	
	make_deer()

func reload_moose(m:String):
	if spawn_name != m: return
	
	get_node("moose_reload").set_wait_time(30)
	get_node("moose_reload").start()

func make_deer():
	if gamestate.state.animal.moose[spawn_name] == 1:
		var moose_obj = moose.instance()
		rng.randomize()
		var get_rand = deer_random_spawn[spawn_name]
		moose_obj.global_position = Vector2(get_rand[0] + round(rng.randf_range(0,1000)), get_rand[1] + round(rng.randf_range(0,1000)))
		get_node("moose").add_child(moose_obj)
		yield(get_tree().create_timer(0.2),"timeout")
	else:
		reload_moose(spawn_name)
# ------------------------------ Signals -------------------------------
	
func _on_moose_reload_timeout():
	gamestate.state.animal.moose[spawn_name] = 1
	
	make_deer()



