extends KinematicBody2D

var death = false

export (int) var speed = 100
var velocity = Vector2()
var direction_move = "right"
var facing_right = true

const footstep = preload("res://effects/foot_step/foot_step.tscn")
const STEP_RATE = 50
var cur_step_dist = 0

#onready var rabbit_hole = get_owner()
onready var rabbit_hole = get_parent().get_parent()

onready var nav_2d = get_parent().get_parent().get_parent().get_parent().get_node("Navigation2D")
#onready var line_2d = get_parent().get_parent().get_parent().get_node("Line2D")

const blood_effect = preload("res://effects/blood/blood_effect.tscn")
const drop_item_popup_ins = preload("res://props/animals/drop_item_popup.tscn")

var rng = RandomNumberGenerator.new()
var rnd_range = 300

onready var end_path = self.global_position
onready var start_path = Vector2()
var current_pos = Vector2()

var path = PoolVector2Array() setget set_path

onready var timer = get_node("Timer")

var max_health = 20
onready var health = max_health setget set_health

var queue_use_pick = false

var have_item_for_quest = false

var is_move = false

enum {
	NULL,
	IDLE,
	ESCAPE,
	FORAGING
}

var state = NULL

onready var anim_player = $AnimationPlayer

func _ready():
	#print(rabbit_hole.name+" position = "+str(rabbit_hole.position))
	
	var _tmp1 = $hurtbox.connect("area_entered",self,"_on_hurtbox_area_entered")
	
	"""
	var _tmp2 = $drop_item_popup_x/background.connect("mouse_entered", self, "_on_drop_item_mouse_extered")
	var _tmp3 = $drop_item_popup_x/background/pick.connect("mouse_entered", self, "_on_drop_item_mouse_extered")
	var _tmp4 = $drop_item_popup_x/background.connect("mouse_exited", self, "_on_drop_item_mouse_exited")
	var _tmp5 = $drop_item_popup_x/background/pick.connect("mouse_exited", self, "_on_drop_item_mouse_exited")
	"""
	
	set_process(false)
	move_to_foraging()
	
	
func _process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)
	
	if is_move:
		cur_step_dist += speed * delta
		if cur_step_dist > STEP_RATE:
			cur_step_dist -= STEP_RATE
			step()
	
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func move_to_foraging():
	rng.randomize()

	var x_foraging = round(rng.randf_range(rabbit_hole.global_position.x - rnd_range,rabbit_hole.global_position.x + rnd_range))
	rng.randomize()
	var y_foraging = round(rng.randf_range(rabbit_hole.global_position.y - rnd_range,rabbit_hole.global_position.y + rnd_range))
	
	#rng.randomize()
	#print(round(rng.randf_range(50,100)))
	
	var new_path = nav_2d.get_simple_path(self.global_position,Vector2(x_foraging,y_foraging))
	#line_2d.points = new_path
	self.path = new_path
	
func move_to_rabbit_hole():
	timer.stop()
	play_anim("walk")
	state = ESCAPE
	speed = 300
	
	var new_path = nav_2d.get_simple_path(self.global_position,rabbit_hole.position)
	#line_2d.points = new_path
	self.path = new_path
	

var left_step = false
func step():
#	if !spawn_steps:
#		return
	left_step = !left_step
	var steps = []
	for i in range(2):
		var f = footstep.instance()
		get_tree().get_root().add_child(f)
		get_tree().get_root().move_child(f, 0)
		steps.append(f)
		f.add_to_group("delete_on_restart")
	
	if left_step:
		steps[0].global_position = global_position + Vector2(15, 12)
		steps[1].global_position = global_position + Vector2(-15, -12)
	else:
		steps[0].global_position = global_position + Vector2(15, -12)
		steps[1].global_position = global_position + Vector2(-15, 12)
		
func flip():
	$graphic.scale.x *= -1
	facing_right = !facing_right
	
func flip_right():
	if $graphic.scale.x != 1:
		$graphic.scale.x *= -1
		$hurtbox.scale.x *= -1

func flip_left():
	if $graphic.scale.x != -1:
		$graphic.scale.x *= -1
		$hurtbox.scale.x *= -1
		
func set_health(value):
	health = value
	if health <= 0:
		death = true
		drop_item()

func drop_item():
	set_process(false)
	timer.stop()
	
	$death_blood.show()
	
	$graphic.scale.y = -1
	$hurtbox/CollisionPolygon2D.set_deferred("disabled", true)
	$eye_detection/CollisionShape2D.set_deferred("disabled", true)
	
	$check_sound_gun/CollisionShape2D.set_deferred("disabled", true)
	
	# แสดงตัวเช็คสำหรับเปิดป็อปอัพดรอป
	$drop_item_check_player/CollisionShape2D.set_deferred("disabled", false)
	
	## rabbit hole parent node
	rabbit_hole._rabbit_death_check()
	
	#check_item_quest_drop()
	have_item_for_quest = checkquest.check_quest_drop(["913"])
	if have_item_for_quest:
		make_drop_popup(self, "rabbit", ["202"], ["913"], 90, 80)
	else:
		make_drop_popup(self, "rabbit", ["202"], [], 90, 80)
	
	$queue_free_timer.set_wait_time(15)
	$queue_free_timer.start()

# uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu use in drop item popup uuuuuuuuuuuuuuuuuuuuuuu
func _pick_item_is_success():
	queue_use_pick = true
	rabbit_hole._rabbit_delete_check()
	
	have_item_for_quest = false
	queue_free()
	
func make_drop_popup(obj:Object, animal_type:String, item_key:Array, item_drop_key:Array, experience:int, money:int):
	if has_node("drop_item_popup"): return
		
	var drop_item_popup_obj = drop_item_popup_ins.instance()
	drop_item_popup_obj.set_data(obj, animal_type, item_key, item_drop_key, experience, money)
	add_child(drop_item_popup_obj)
	
func take_damage(d):
	var damage = health - d
	self.health = damage
	
	var blood_eff_obj = blood_effect.instance()
	blood_eff_obj.emitting = true
	blood_eff_obj.global_position = Vector2(position.x, position.y)
	get_parent().add_child(blood_eff_obj)
	
	if death: return
	#chase_velocity = chase_velocity.move_toward(Vector2.ZERO, 0)
	#state = NULL
	#yield(get_tree().create_timer(1),"timeout")
	#state = CHASE
	
# ======================= path finding with tilemap =======================
func move_along_path(distance):
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			global_position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			""" =========================================== """ 
			current_pos = global_position
			play_anim("walk")
			is_move = true
			if start_path < current_pos:
				flip_right()
				pass
			else:
				flip_left()
				pass
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			set_process(false)
			""" =========================================== """
			play_anim("idle")
			is_move = false
			
			# หนีลงหลุม
			if state == ESCAPE:
				rabbit_hole.state = 2
				rabbit_hole._rabbit_delete_check()
				queue_free()
				
			rng.randomize()
			timer.set_wait_time(round(rng.randf_range(5,10)))
			#timer.set_wait_time(5)
			timer.start()
			""" =========================================== """
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """

func set_path(value):
	path = value
	#path.remove(0)
	if value.size() == 0:
		return
	set_process(true)
# ======================= end path finding with tilemap =======================

func shocked_sound_gun():
	move_to_rabbit_hole()

"""
func check_item_quest_drop():
	
	# ทำเควสหมดแล้ว
	if gamestate.state.quest.success_all == 1: return
	
	# ยังไม่รับเควส
	if gamestate.state.quest.accepted_quest == 0: return
	
	# เควสปัจจุบันเสร็จแล้ว
	if gamestate.state.quest.success_current_quest == 1: return
	
	# ลูปไอเทมที่ต้องการทั้งหมด
	for i in JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"]:
		
		#if JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][str(i)] == "913":

		# ถ้าไอเทมที่ต้องการในปัจจุบันเป็นของที่ต้องการเช่น เนื้อกระต่าย
		if JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][str(i)] == "913":
			
			# ถ้าในตัวยังไม่มี
			if gamestate.state.quest["tmp_item_quest"]["913"] == 0:
				#$drop_item_popup/background/quest_requite.show()
				have_item_for_quest = true
				return
"""

# ---------------------------- Signals ---------------------------------------


func _on_hurtbox_area_entered(_area):
	print('hello world x')

func _on_Timer_timeout():
	timer.stop()
	move_to_foraging()




func _on_queue_free_timer_timeout():
	rabbit_hole._rabbit_delete_check()
	queue_free()


func _on_drop_item_check_player_body_entered(body):
	if body.name == "player":
		$queue_free_timer.stop()
		"""
		$drop_item_popup_x.show()
		"""
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").show()

func _on_drop_item_check_player_body_exited(body):
	if body.name == "player" and !queue_use_pick:
		$queue_free_timer.set_wait_time(15)
		$queue_free_timer.start()
		"""
		$drop_item_popup_x.hide()
		"""
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").hide()
	check.mouse_on_gui = false


func _on_pick_pressed():
	
	if game.inventory == null: return
	
	if have_item_for_quest:
		var affectedSlot = DataParser.inventory_addItem(913)
		if (affectedSlot >= 0):
			game.inventory.update_slot(affectedSlot)
			
			# quest
			gamestate.state.quest["tmp_item_quest"]["913"] = 1
			checkquest.update_quest_status()
	
	var affectedSlot = DataParser.inventory_addItem(202)
	if (affectedSlot >= 0):
		game.inventory.update_slot(affectedSlot)
	
	queue_use_pick = true
	rabbit_hole._rabbit_delete_check()
	
	have_item_for_quest = false
	queue_free()

func _on_drop_item_mouse_extered():
	check.mouse_on_gui = true

func _on_drop_item_mouse_exited():
	check.mouse_on_gui = false


func _on_eye_detection_area_entered(area):
	if area.name == "eye_detection":
		move_to_rabbit_hole()


func _on_check_sound_gun_area_entered(area):
	if area.name == "gun_shoot_sound_area":
		shocked_sound_gun()
