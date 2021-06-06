extends Node

const camping = preload("res://props/camping/camping.tscn")

const wolf = preload("res://props/animals/wolf/wolf.tscn")

const moose = preload("res://props/animals/moose/moose.tscn")

const boss_wolf = preload("res://props/animals/boss_wolf/boss_wolf.tscn")

# gdscrip module
var rng = RandomNumberGenerator.new()

func _ready():
	#if game.main == null: return
	game.main_map = self
	
	if game.main != null:
		game.main.music_fsm(1)
	
	check_camping()
	
	if game.hud != null:
		yield(get_tree().create_timer(1),"timeout")
		game.hud.get_node("zone_alert_fade/AnimationPlayer").play("play")
	
func _input(_event):
	if Input.is_action_just_pressed("set_up_tent"):
		if gamestate.state.camping.set_up_a_camp == 0: 
			var camping_obj = camping.instance()
			camping_obj.global_position = Vector2(game.player.global_position.x, game.player.global_position.y)
			get_node("YSort/camp_zone").add_child(camping_obj)
			
			gamestate.state.camping.set_up_a_camp = 1
			gamestate.state.camping.camp_pos = [game.player.global_position.x, game.player.global_position.y]
			
			game.text_alert.add_data_to_play("กางแคมป์สำเร็จ")
			
func check_camping():
	var setup = gamestate.state.camping.set_up_a_camp
	if setup == 0:
		pass
	elif setup == 1:
		var camping_obj = camping.instance()
		camping_obj.global_position = Vector2(gamestate.state.camping.camp_pos[0], gamestate.state.camping.camp_pos[1])
		get_node("YSort/camp_zone").add_child(camping_obj)
	
	
var zone = ["A","B","C","D"]
#var zone = ["A","B"]
var sub_zone = {
#	"A": ["A2","A3","A4"],
#	"B": ["B2","B3","B4"],
#	"C": ["C2","C3","C4"],
#	"D": ["D2","D3","D4"]
	"A": ["A1","A2","A3","A4"],
	"B": ["B1","B2","B3","B4"],
	"C": ["C1","C2","C3","C4"],
	"D": ["D1","D2","D3","D4"]
}

var random_spawn = {
	# - , -
	"A1": [-4000, -4000],
	"A2": [-2000, -7000],
	"A3": [-7000, -7000],
	"A4": [-7000, -2000],
	
	# + , -
	"B1": [4000, -4000],
	"B2": [2000, -7000],
	"B3": [7000, -7000],
	"B4": [7000, -2000],
	
	# - , +
	"C1": [-4000, 4000],
	"C2": [-2000, 7000],
	"C3": [-7000, 7000],
	"C4": [-7000, 2000],
	
	# + , +
	"D1": [4000, 4000],
	"D2": [2000, 7000],
	"D3": [7000, 7000],
	"D4": [7000, 2000],
}

#var deer_zone = ["A","B","C","D"]
#var deer_sub_zone = {
#	"A": ["A1","A2","A3","A4"],
#	"B": ["B1","B2","B3","B4"],
#	"C": ["C1","C2","C3","C4"],
#	"D": ["D1","D2","D3","D4"]
#}
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

var wolf_count = 3
func make_wolf():
	print(gamestate.state.quest.current_quest)
	for n in wolf_count:
		for i in zone:
			for j in sub_zone[i]:
				
				if (j == "A4" or j == "B4" or j == "C4" or j == "D4") and gamestate.state.quest.current_quest == "009" and n == 1 and gamestate.state.accepted_quest == 1:
					var boss_wolf_obj = boss_wolf.instance()
					rng.randomize()
					var get_rand = random_spawn[j]
					boss_wolf_obj.global_position = Vector2(get_rand[0] + round(rng.randf_range(0,1000)), get_rand[1] + round(rng.randf_range(0,1000)))
					get_node("YSort/animal_zone").get_node(i).get_node(j).get_node("wolf").add_child(boss_wolf_obj)
					boss_wolf_obj.initiate_wolf()
					yield(get_tree().create_timer(0.1),"timeout")
					
				var wolf_obj = wolf.instance()
				rng.randomize()
				var get_rand = random_spawn[j]
				wolf_obj.global_position = Vector2(get_rand[0] + round(rng.randf_range(0,1000)), get_rand[1] + round(rng.randf_range(0,1000)))
				get_node("YSort/animal_zone").get_node(i).get_node(j).get_node("wolf").add_child(wolf_obj)
				wolf_obj.initiate_wolf()
				yield(get_tree().create_timer(0.1),"timeout")
	
func delete_wolf():
	for n in wolf_count:
		for i in zone:
			for j in sub_zone[i]:
				if get_node("YSort/animal_zone").get_node(i).get_node(j).get_node("wolf").get_child_count() > 0:
					for k in get_node("YSort/animal_zone").get_node(i).get_node(j).get_node("wolf").get_children():
						if k != null:
							k.queue_free()
							yield(get_tree().create_timer(0.1),"timeout")

func make_deer():
	for i in gamestate.state.animal.moose:
		if gamestate.state.animal.moose[i] == 1:
			var moose_obj = moose.instance()
			rng.randomize()
			var get_rand = deer_random_spawn[i]
			moose_obj.global_position = Vector2(get_rand[0] + round(rng.randf_range(0,1000)), get_rand[1] + round(rng.randf_range(0,1000)))
			get_node("YSort/animal_zone/moose_spawn").get_node(i).get_node("moose").add_child(moose_obj)
			yield(get_tree().create_timer(0.2),"timeout")
			
func delete_deer():
	pass
