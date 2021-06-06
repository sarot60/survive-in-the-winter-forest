extends KinematicBody2D

# gdscrip module
var rng = RandomNumberGenerator.new()

var death = false

onready var Check_zone = preload("res://scripts/check_zone/check_zone.gd").new()

const blood_effect = preload("res://effects/blood/blood_effect.tscn")

const deer_foot_step = preload("res://props/foot_step/deer_foot_step/deer_foot_step.tscn")

const off_screen_deer_foot = preload("res://props/animals/moose/off_screen_deer_foot.tscn")
const dog_find_deer_marker = preload("res://props/animals/moose/dog_find_deer_marker.tscn")


var ACCELERATION = 500 # chane from 300
var MAX_SPEED = 300 # chane from 50
var FRICTION = 600 # change from 200

### ai attack
enum{
	IDLE, # ยื่นเฉยๆ
	WANDER, # เดิน
	FORAGING, # หาอาหาร
	ESCAPE, # หนี
	INTERESTED, # สนใจ
	DEATH, # ตาย
	SHOCKED # ตกใจเสียงปืน
}

onready var anim_player = $AnimationPlayer

var state = FORAGING

export (int) var speed = 500

var path = PoolVector2Array() setget set_path
onready var nav_2d = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Navigation2D")
var start_path = Vector2()
var current_pos = Vector2()

onready var escape_timer = get_node("escape_timer")
onready var interested_timer = get_node("interested_timer")
onready var foragaing_timer = get_node("foraging_timer")
onready var shocked_timer = get_node("shocked_timer")

onready var parent_zone = get_parent().get_parent()

var velocity = Vector2.ZERO

const drop_item_popup_ins = preload("res://props/animals/drop_item_popup.tscn")

var is_escape = false

# --- player ---
var p = null

var max_health = 100
onready var health = max_health setget set_health

"""-----------------------------------------------------------------------
 							Godot Function
#----------------------------------------------------------------------"""

func _ready():
	#set_process(false)
	
	#yield(get_tree(), "idle_frame")
	#foraging_state_cycle() 
	pass
	
var x = 0
func _process(delta):
	
	if death: return
	
	match state:
		IDLE:
			#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			play_anim("idle")
			pass
		
		FORAGING:
			foraging_state_cycle()
			
		ESCAPE:
			var move_distance = speed * delta
			escape_move_along_path(move_distance)
			
			if is_escape:
				x += delta
				if x > 0.3:
					var deer_foot_step_obj = deer_foot_step.instance()
					deer_foot_step_obj.global_position = $foot_step.global_position
					#get_tree().get_root().add_child(deer_foot_step_obj)
					get_parent().get_node("mooseeff_1").add_child(deer_foot_step_obj)
					x = 0
			
		WANDER:
			var move_distance = speed * delta
			move_along_path(move_distance)
			
		INTERESTED:
			var move_distance = speed * delta
			interested_move_along_path(move_distance)
			
		SHOCKED:
			var move_distance = speed * delta
			shocked_move_along_path(move_distance)
			
			
"""-----------------------------------------------------------------------
 							My Function
#----------------------------------------------------------------------"""
func foraging_state_cycle(): # หาอาหาร
	
	#rng.randomize()
	#var x_foraging = round(rng.randf_range(5000,10000))
	#rng.randomize()
	#var y_foraging = round(rng.randf_range(5000,10000))
	#var new_path = nav_2d.get_simple_path(self.global_position,Vector2(x_foraging,y_foraging))
	
	#var new_path = nav_2d.get_simple_path(self.global_position,Vector2(Check_zone.random_move(Check_zone.zone)))
	
	var new_path = nav_2d.get_simple_path(self.global_position,Vector2(Check_zone.random_move(parent_zone.name)))
	#line_2d.points = new_path
	self.path = new_path
	
	play_anim("run")
	
	state = WANDER
	
func escape():
	#print('moose_position=',self.global_position)
	#print('player_position=',p.global_position)
	if death: return
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
	
	if !is_escape:
		
		# off screen
		var off_screen_deer_foot_obj = off_screen_deer_foot.instance()
		#off_screen_deer_foot_obj.set_physics_process(true)
		#off_screen_deer_foot_obj.show()
		off_screen_deer_foot_obj.global_position = $foot_step.global_position
		get_parent().get_node("mooseeff_1").add_child(off_screen_deer_foot_obj)
		
		# marker
		var dog_find_deer_marker_obj = dog_find_deer_marker.instance()
		dog_find_deer_marker_obj.global_position = $foot_step.global_position
		get_parent().get_node("mooseeff_1").add_child(dog_find_deer_marker_obj)
		
		var deer_foot_step_obj = deer_foot_step.instance()
		deer_foot_step_obj.global_position = $foot_step.global_position
		get_parent().get_node("mooseeff_1").add_child(deer_foot_step_obj)
		
	is_escape = true
	
	play_anim("run")
	
	var direction = (p.global_position - self.global_position).normalized()
	
	var to_x = self.global_position.x + (-direction.x * 1000)
	var to_y = self.global_position.y + (-direction.y * 1000)
	
	if to_x >= 10000 or to_y >= 10000 or to_x <= -10000 or to_y <= -10000:
		if parent_zone.name == "A1" \
			or parent_zone.name == "B1" \
			or parent_zone.name == "C1" \
			or parent_zone.name == "D1":
				foraging_state_cycle()
		elif parent_zone.name == "A2":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-7500, -7500))
				self.path = new_path
		elif parent_zone.name == "A3":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-2500, -2500))
				self.path = new_path
		elif parent_zone.name == "A4":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-7500, -7500))
				self.path = new_path
		
		elif parent_zone.name == "B2":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(7500, -7500))
				self.path = new_path
		elif parent_zone.name == "B3":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(2500, -2500))
				self.path = new_path
		elif parent_zone.name == "B4":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(7500, -7500))
				self.path = new_path
			
		elif parent_zone.name == "C2":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-7500, 7500))
				self.path = new_path
		elif parent_zone.name == "C3":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-2500, 2500))
				self.path = new_path
		elif parent_zone.name == "C4":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(-7500, 7500))
				self.path = new_path
			
		elif parent_zone.name == "D2":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(7500, 7500))
				self.path = new_path
		elif parent_zone.name == "D3":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(2500, 2500))
				self.path = new_path
		elif parent_zone.name == "D4":
			Check_zone.get_zone(self.global_position)
			if parent_zone.name != Check_zone.zone:
				foraging_state_cycle()
			else:
				var new_path = nav_2d.get_simple_path(self.global_position,Vector2(7500, 7500))
				self.path = new_path
			
		state = ESCAPE
		return

	var new_path = nav_2d.get_simple_path(self.global_position,Vector2(to_x, to_y))
	#line_2d.points = new_path
	self.path = new_path
	state = ESCAPE

func interested():
	if death: return
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
	
	play_anim("run")
	
	var direction = (p.global_position - self.global_position).normalized()
	
	var to_x = self.global_position.x + (direction.x * 200)
	var to_y = self.global_position.y + (direction.y * 200)
	
	var new_path = nav_2d.get_simple_path(self.global_position,Vector2(to_x, to_y))
	#line_2d.points = new_path
	self.path = new_path
	
	state = INTERESTED
	pass

func shocked():
	if death: return
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
	
	if is_escape:
		is_escape = false
	
		$off_screen_moose.hide()
		$off_screen_moose.set_physics_process(false)
		
		if get_parent().get_node("mooseeff_1").get_child_count() > 0:
			for i in get_parent().get_node("mooseeff_1").get_children():
				if i != null:
					i.queue_free()
					yield(get_tree().create_timer(0.1),"timeout")

	play_anim("run")
	
	var direction = (p.global_position - global_position).normalized()
	
	var to_x = global_position.x + (-direction.x * 1500)
	var to_y = global_position.y + (-direction.y * 1500)
	
	var new_path = nav_2d.get_simple_path(global_position,Vector2(to_x, to_y))
	#line_2d.points = new_path
	self.path = new_path
	
	state = SHOCKED


func set_path(value):
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
	
func move_along_path(distance):
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			
			
			# ---------------------- my add na kub ---------------------------
			if distance == 0 or distance_to_next == 0: return
			
			
			global_position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			""" =========================================== """ 
			current_pos = global_position
			if start_path < current_pos:
				flip_left()
			else:
				flip_right()
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			#set_process(false)
			state = IDLE
			""" =========================================== """
			#play_anim("idle")
			rng.randomize()
			foragaing_timer.set_wait_time(round(rng.randf_range(5,10)))
			#timer.set_wait_time(5)
			foragaing_timer.start()
			""" =========================================== """
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """

func flip_right():
	if $Sprite.scale.x != -1:
		$Sprite.scale.x *= -1
		$hurtbox.scale.x *= -1
		$calling_callback.scale.x *= -1
		
		$graphic.scale.x *= -1
	
func flip_left():
	if $Sprite.scale.x != 1:
		$Sprite.scale.x *= -1
		$hurtbox.scale.x *= -1
		$calling_callback.scale.x *= -1
		
		$graphic.scale.x *= -1
		
	
func escape_move_along_path(distance):
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			global_position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			current_pos = global_position
			""" =========================================== """ 
			if start_path < current_pos:
				flip_left()
				#print('left')
			else:
				flip_right()
				#print('right')
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			#set_process(false)
			rng.randomize()
			escape_timer.set_wait_time(round(rng.randf_range(15,20)))
			escape_timer.start()
			state = IDLE
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """
		
func interested_move_along_path(distance):
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			global_position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			current_pos = global_position
			""" =========================================== """ 
			if start_path < current_pos:
				flip_left()
			else:
				flip_right()
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			#set_process(false)
			rng.randomize()
			interested_timer.set_wait_time(round(rng.randf_range(15,20)))
			interested_timer.start()
			state = IDLE
			
			yield(get_tree().create_timer(4),"timeout")
			if !death:
				$calling_callback.visible = true
				$calling_callback/AnimationPlayer.play("start_call")
				
				$off_screen_moose.show()
				$off_screen_moose.set_physics_process(true)
				$callback_sound.play()
				#yield(get_tree().create_timer(5),"timeout")
				#$callback.stop()
			
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """

func shocked_move_along_path(distance):
	var start_point = global_position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			global_position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			current_pos = global_position
			""" =========================================== """ 
			if start_path < current_pos:
				flip_left()
				#print('left')
			else:
				flip_right()
				#print('right')
			""" =========================================== """
			break
		elif path.size() == 1 and distance >= distance_to_next:
		#elif distance < 0.0:
			global_position = path[0]
			#set_process(false)
			rng.randomize()
			shocked_timer.set_wait_time(round(rng.randf_range(15,20)))
			shocked_timer.start()
			state = IDLE
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		""" =========================================== """
		start_path = global_position
		""" =========================================== """
	
	
func take_damage(d):
	var damage = health - d
	self.health = damage
	
	var blood_eff_obj = blood_effect.instance()
	blood_eff_obj.emitting = true
	blood_eff_obj.global_position = Vector2(global_position.x, global_position.y - 32)
	get_parent().add_child(blood_eff_obj)
	
	if death: return
	#chase_velocity = chase_velocity.move_toward(Vector2.ZERO, 0)
	#state = NULL
	#yield(get_tree().create_timer(1),"timeout")
	#state = CHASE
	
func set_health(value):
	health = value
	if health <= 0:
		death = true
		play_anim("idle")
		drop_item()
		
func drop_item():
	$death_blood.show()
	
	set_process(false)
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
	
	$callback_sound.stop()
	
	$shadow.hide()
	
	$calling_callback.hide()
	$off_screen_moose.hide()
	$off_screen_moose.set_physics_process(false)
	
	#p = null
	
	$Sprite.scale.y = -1
	$graphic.scale.y = -1
	
	$player_detection/CollisionShape2D.set_deferred("disabled", true)
	$hurtbox/CollisionPolygon2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	
	$check_sound_gun/CollisionShape2D.set_deferred("disabled", true)
	
	# เปิดให้ดรอป
	$drop_item_check_player/CollisionShape2D.set_deferred("disabled", false)
	
	#check_item_quest_drop()
	var have_item_for_quest:bool = checkquest.check_quest_drop(["914"])
	if have_item_for_quest:
		make_drop_popup(self, "deer", ["203"], ["914"], 200, 120)
	else:
		make_drop_popup(self, "deer", ["203"], [], 200, 120)
	
	
	play_anim("idle")
	
	$queue_free_timer.set_wait_time(15)
	$queue_free_timer.start()
	
func make_drop_popup(obj:Object, animal_type:String, item_key:Array, item_drop_key:Array, experience:int, money:int):
	if has_node("drop_item_popup"): return
		
	var drop_item_popup_obj = drop_item_popup_ins.instance()
	drop_item_popup_obj.set_data(obj, animal_type, item_key, item_drop_key, experience, money)
	add_child(drop_item_popup_obj)

# uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu use in drop item popup uuuuuuuuuuuuuuuuuuuuuuu
func _pick_item_is_success():
	
	if has_node("drop_item_popup"):
		get_node("drop_item_popup").queue_free()
	
	if get_parent().get_node("mooseeff_1").get_child_count() > 0:
		for i in get_parent().get_node("mooseeff_1").get_children():
			i.queue_free()
			yield(get_tree().create_timer(0.1),"timeout")
	
	gamestate.state.animal.moose[get_parent().get_parent().name] = 0
	get_tree().call_group("reload_moose","reload_moose", get_parent().get_parent().name)
	
	queue_free()

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

"""-----------------------------------------------------------------------
 								Signal
#----------------------------------------------------------------------"""

func _on_player_detection_area_entered(area):
	if area.name == "calling_area":
		$calling_callback.hide()
		$calling_callback/AnimationPlayer.stop()
		$callback_sound.stop()
		
		p = area.get_parent()
		
		interested_timer.stop()
		escape_timer.stop()
		foragaing_timer.stop()
		shocked_timer.stop()
		
		interested()
		state = INTERESTED
		
		$off_screen_moose.hide()
		$off_screen_moose.set_physics_process(false)
		
	
	if area.name == "eye_detection":
		$calling_callback.hide()
		$calling_callback/AnimationPlayer.stop()
		$callback_sound.stop()
		
		p = area.get_parent()
		
		interested_timer.stop()
		escape_timer.stop()
		foragaing_timer.stop()
		shocked_timer.stop()
		
		escape()
		state = ESCAPE
		
		game.pet_dog.bark()
		
		$off_screen_moose.hide()
		$off_screen_moose.set_physics_process(false)


func _on_interested_timer_timeout():
	$calling_callback.hide()
	$calling_callback/AnimationPlayer.stop()
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
		
	foraging_state_cycle()
	#state = FORAGING
	
	$off_screen_moose.hide()
	$off_screen_moose.set_physics_process(false)


func _on_foraging_timer_timeout():
	$calling_callback.hide()
	$calling_callback/AnimationPlayer.stop()
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
		
	foraging_state_cycle()
	#state = FORAGING
	
	$off_screen_moose.hide()
	$off_screen_moose.set_physics_process(false)

func _on_escape_timer_timeout():
	$calling_callback.hide()
	$calling_callback/AnimationPlayer.stop()
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
		
	foraging_state_cycle()
	#state = FORAGING
	
	is_escape = false
	
	$off_screen_moose.hide()
	$off_screen_moose.set_physics_process(false)
	
	if get_parent().get_node("mooseeff_1").get_child_count() > 0:
		for i in get_parent().get_node("mooseeff_1").get_children():
			i.queue_free()
			yield(get_tree().create_timer(0.1),"timeout")


func _on_queue_free_timer_timeout():
	
	if get_parent().get_node("mooseeff_1").get_child_count() > 0:
		for i in get_parent().get_node("mooseeff_1").get_children():
			i.queue_free()
			yield(get_tree().create_timer(0.1),"timeout")
	
	gamestate.state.animal.moose[get_parent().get_parent().name] = 0
	get_tree().call_group("reload_moose","reload_moose", get_parent().get_parent().name)
	
	queue_free()


func _on_shocked_timer_timeout():
	$calling_callback.hide()
	$calling_callback/AnimationPlayer.stop()
	
	interested_timer.stop()
	escape_timer.stop()
	foragaing_timer.stop()
	shocked_timer.stop()
		
	foraging_state_cycle()
	#state = FORAGING
	
	$off_screen_moose.hide()
	$off_screen_moose.set_physics_process(false)


func _on_drop_item_check_player_body_entered(body):
	if body.name == "player":
		$queue_free_timer.stop()
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").show()

func _on_drop_item_check_player_body_exited(body):
	if body.name == "player":
		$queue_free_timer.set_wait_time(15)
		$queue_free_timer.start()
		if has_node("drop_item_popup"):
			get_node("drop_item_popup").hide()
		check.mouse_on_gui = false

func _on_check_sound_gun_area_entered(area):
	if death: return
	if area.name == "gun_shoot_sound_area" or area.name == "village_area":
		$calling_callback.hide()
		$calling_callback/AnimationPlayer.stop()
		$callback_sound.stop()
			
		p = area.get_parent()
			
		interested_timer.stop()
		escape_timer.stop()
		foragaing_timer.stop()
		shocked_timer.stop()
			
		shocked()
		state = SHOCKED
		
		$off_screen_moose.hide()
		$off_screen_moose.set_physics_process(false)
