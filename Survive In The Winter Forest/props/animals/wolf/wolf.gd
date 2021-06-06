extends KinematicBody2D

onready var Check_zone = preload("res://scripts/check_zone/check_zone.gd").new()

var ACCELERATION = 1000 # chane from 300
var MAX_SPEED = 200 # chane from 50
var FRICTION = 600 # change from 200

# gdscrip module
var rng = RandomNumberGenerator.new()

### ai attack
enum{
	IDLE, # ยื่นเฉลๆ
	WANDER, # เดิน
	CHASE, # ไล่ล่า
	ATTACK, # โจมตี
	KNOCK_BACK, # ถูกตี
	FORAGING, # หาอาหาร
	NULL
}

var state = IDLE

#onready var stats = $wolf_stats
#onready var playerDetectionZone = $PlayerDetectionZone
onready var tooth_hitbox = $hitbox/tooth_hitbox

var chase_velocity = Vector2.ZERO

export (int) var speed = 200

var knockback = Vector2.ZERO

var death = false

const footstep = preload("res://effects/foot_step/foot_step.tscn")
const STEP_RATE = 100
var cur_step_dist = 0

var path = PoolVector2Array() setget set_path
onready var nav_2d = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Navigation2D")
#onready var line_2d = get_parent().get_parent().get_node("Line2D")
var start_path = Vector2()
var current_pos = Vector2()

onready var queue_free_timer = get_node("queue_free_timer")
onready var foraging_timer = get_node("foraging_timer")

onready var parent_zone = get_parent().get_parent()

const blood_effect = preload("res://effects/blood/blood_effect.tscn")

const drop_item_popup_ins = preload("res://props/animals/drop_item_popup.tscn")

var player = null

var max_health = 100
onready var health = max_health setget set_health

onready var anim_player = $AnimationPlayer

""" ======================================================================================="""
""" =====================================  code working ==================================="""
""" ======================================================================================="""

func _ready():
	set_process(false)
	#$head_debug.text = str(self.health)

func _process(delta):
	match state:
		IDLE:
			#chase_velocity = chase_velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			#seek_player()
			if player != null:
				state = CHASE
			pass
			
		WANDER:
			var move_distance = speed * delta
			foraging_move_along_path(move_distance)
			#seek_player()
			
#			cur_step_dist += speed * delta
#			if cur_step_dist > STEP_RATE:
#				cur_step_dist -= STEP_RATE
#				step()
				
		CHASE:
			#var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				chase_velocity = chase_velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				
				tooth_hitbox.wolf_position = self.global_position
				
				play_anim("walk")
				
				cur_step_dist += speed * delta
				if cur_step_dist > STEP_RATE:
					cur_step_dist -= STEP_RATE
					step()
					
				if direction.x <= 0:
					flip_right()
				else:
					flip_left()
			else:
				state = IDLE
				play_anim("idle")
			chase_velocity = move_and_slide(chase_velocity)
		
		FORAGING:
			foraging_state_cycle()
		
		ATTACK:
			pass
		
		KNOCK_BACK:
			chase_velocity = chase_velocity.move_toward(Vector2.ZERO, 500 * delta)
			state = IDLE
			chase_velocity = move_and_slide(chase_velocity)
		
		NULL:
			pass

func initiate_wolf():
	state = FORAGING
	set_process(true)

func seek_player():
	#if playerDetectionZone.can_see_player():
	#	foraging_timer.stop()
	#	state = CHASE
	pass
	
func set_health(value):
	health = value
	if health <= 0:
		death = true
		drop_item()

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
		
func foraging_move_along_path(distance):
	if death: return
	
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			
			
			# ---------------------- my add na kub ---------------------------
			if distance == 0 or distance_to_next == 0: return
			
			
			global_position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			""" =========================================== """ 
			current_pos = global_position
			play_anim("walk")

				
			if start_path < current_pos:
				flip_left()
			else:
				flip_right()
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			set_process(false)
			state = IDLE
			""" =========================================== """
			play_anim("idle")
			rng.randomize()
			foraging_timer.set_wait_time(round(rng.randf_range(5,10)))
			foraging_timer.start()
			""" =========================================== """
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """
	pass

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
"""
life cycle state
"""
func foraging_state_cycle(): # หาอาหาร
	if death: return
	
	#rng.randomize()
	#var x_foraging = round(rng.randf_range(5000,10000))
	#rng.randomize()
	#var y_foraging = round(rng.randf_range(5000,10000))
	#var new_path = nav_2d.get_simple_path(self.global_position,Vector2(x_foraging,y_foraging))
	
	#var new_path = nav_2d.get_simple_path(self.global_position,Vector2(Check_zone.random_move(Check_zone.zone)))
	
	var new_path = nav_2d.get_simple_path(self.global_position,Vector2(Check_zone.random_move(parent_zone.name)))
	#line_2d.points = new_path
	self.path = new_path
	
	state = WANDER

func escape_state_cycle(): # หนี
	
	pass
	 
func interested_state_cycle(): # สนใจ

	pass
	
func eat_state_cycle(): # กิน
	
	pass
	
func sleep_state_cycle(): # นอน
	
	pass

func death_state_cycle(): # ตาย
	
	pass
"""
end life cycle state
"""

# move
func set_path(value):
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
func take_damage(d):
	
	var damage = health - d
	self.health = damage
	#$head_debug.text = str(self.health)
	
	var blood_eff_obj = blood_effect.instance()
	blood_eff_obj.emitting = true
	blood_eff_obj.global_position = Vector2(global_position.x, global_position.y - 32)
	get_parent().add_child(blood_eff_obj)
	
	if death: return
	chase_velocity = chase_velocity.move_toward(Vector2.ZERO, 0)
	state = NULL
	yield(get_tree().create_timer(1),"timeout")
	state = CHASE

func drop_item():
	
	$death_blood.show()
	
	foraging_timer.stop()
	
	set_process(false)

	player = null
	
	$graphic.scale.y = -1
	
	$seek_player/CollisionShape2D.set_deferred("disabled", true)
	$hitbox/tooth_hitbox/CollisionPolygon2D.set_deferred("disabled", true)
	$hurtbox/CollisionPolygon2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	
	$drop_item_check_player/CollisionShape2D.set_deferred("disabled", false)
	
	#check_item_quest_drop()
	var have_item_for_quest:bool = checkquest.check_quest_drop(["912"])
	if have_item_for_quest:
		make_drop_popup(self, "wolf", ["201"], ["912"], 100, 100)
	else:
		make_drop_popup(self, "wolf", ["201"], [], 100, 100)
	
	queue_free_timer.set_wait_time(15)
	queue_free_timer.start()
	
func make_drop_popup(obj:Object, animal_type:String, item_key:Array, item_drop_key:Array, experience:int, money:int):
	if has_node("drop_item_popup"): return
		
	var drop_item_popup_obj = drop_item_popup_ins.instance()
	drop_item_popup_obj.set_data(obj, animal_type, item_key, item_drop_key, experience, money)
	add_child(drop_item_popup_obj)

# uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu use in drop item popup uuuuuuuuuuuuuuuuuuuuuuu
func _pick_item_is_success():
	queue_free()
	
func flip_right():
	if $graphic.scale.x != -1:
		$graphic.scale.x *= -1
		$hurtbox.scale.x *= -1
		tooth_hitbox.scale.x *= -1

func flip_left():
	if $graphic.scale.x != 1:
		$graphic.scale.x *= -1
		$hurtbox.scale.x *= -1
		tooth_hitbox.scale.x *= -1

func _on_wolf_stats_no_health():
	queue_free()

func _on_hurtbox_area_entered(area):
	if area.name == "sword_hitbox":
		
		# stop หาอาหาร
		#set_process(false)
		foraging_timer.stop()
		
		take_damage(20)
		
		var direction = (area.player_position - global_position).normalized()
		chase_velocity = -direction * 500
		state = KNOCK_BACK


func _on_foraging_timer_timeout():
	if death: return
	
	foraging_timer.stop()
	foraging_state_cycle()


func _on_seek_player_body_entered(body):
	if body.name == "player" and !death:
		player = body
		
		foraging_timer.stop()
		
		set_process(true)
		state = CHASE

func _on_seek_player_body_exited(body):
	if body.name == "player" and !death:
		player = null
		
		set_process(false)
		
		rng.randomize()
		foraging_timer.set_wait_time(round(rng.randf_range(5,10)))
		foraging_timer.start()


func _on_queue_free_timer_timeout():
	queue_free()


func _on_tooth_hitbox_area_entered(area):
	if area.name == "hurtbox" and !death:
		chase_velocity = chase_velocity.move_toward(Vector2.ZERO, 0)
		state = NULL
		yield(get_tree().create_timer(1),"timeout")
		state = CHASE


func _on_drop_item_check_player_body_entered(body):
	if body.name == "player":
		queue_free_timer.stop()
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").show()
		

func _on_drop_item_check_player_body_exited(body):
	if body.name == "player":
		queue_free_timer.set_wait_time(15)
		queue_free_timer.start()
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").hide()
		check.mouse_on_gui = false
