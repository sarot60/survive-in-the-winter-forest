extends KinematicBody2D

export(String, "friendly", "prey", "predator") var role

#var attack_time = 0
#const ATTACK_RATE = 0.8

var spawn_steps = false

const footstep = preload("res://effects/foot_step/foot_step.tscn")
const STEP_RATE = 80
var cur_step_dist = 0

export var move_speed = 120
#var move_speed = 120

const MAX_DIST = 15
const MIN_DIST = 10

var player = null
var target_pos = Vector2()

var facing_right = true
var dead = false

onready var raycast = $RayCast2D
onready var anim_player = $AnimationPlayer

onready var call_anim_player = $call

var is_bark:bool = false

func _ready():
	game.pet_dog = self
	
	self.global_position = Vector2(gamestate.state.pet_current_pos[0],gamestate.state.pet_current_pos[1])
	
	add_to_group("need_player_ref")
	
	add_to_group("player_is_dead")
	
	if role == "prey":
		add_to_group("deer")
	if role == "predator":
		add_to_group("wolves")
	if role == "friendly":
		spawn_steps = true
		

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
		
	if role == "friendly":
		target_pos = -(player.global_position - global_position).normalized() * 60  + player.global_position
		
	var move_vec = target_pos - global_position
	var dist = move_vec.length()
	move_vec = move_vec.normalized()
	
	var speed = move_speed
	
	move_vec = obstacle_avoid(move_vec)
	
	if global_position.distance_to(target_pos) > 15:
		move_and_slide(move_vec * speed, Vector2())
	
	if global_position.distance_to(target_pos) > 100:
		move_speed = 300
		#move_speed = 1000
	else:
		#move_speed = 1000
		move_speed = 120
		
	if dist > MIN_DIST + 5:
		play_anim("walk")
		pass
	else:
		play_anim("idle")
		pass
		
	if move_vec.x < 0.3 and facing_right:
		flip()
	if move_vec.x > 0.3 and !facing_right:
		flip()
	
	if game.player != null:
		if game.player.is_move == true:
			if move_vec != Vector2():
				cur_step_dist += speed * delta
				if cur_step_dist > STEP_RATE:
					cur_step_dist -= STEP_RATE
					step()
	
func set_target(t):
	target_pos = t

func set_position_when_player_dead(_p):
	global_position = Vector2(100, 100)

func flip():
	#$Sprite.scale.x *= -1
	$graphic.scale.x *= -1
	facing_right = !facing_right
	
func set_player(p):
	player = p

var left_step = false
func step():
	if !spawn_steps:
		return
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
		
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
func play_call_anim(anim):
	if call_anim_player.current_animation == anim:
		return
	call_anim_player.play(anim)

func obstacle_avoid(move_vec):
	var new_move_vec = move_vec
	raycast.cast_to = move_vec * 15
	if raycast.is_colliding():
		var n = raycast.get_collision_normal()
		var dir1 = n.rotated(deg2rad(90))
		var dir2 = n.rotated(deg2rad(-90))
		new_move_vec = dir1
		if move_vec.dot(dir1) < move_vec.dot(dir2):
			new_move_vec = dir2
		#print(dir1, dir2, new_move_vec)
	return new_move_vec

func bark():
	if !is_bark:
		play_call_anim("call")
		$bark_sound.play()
		$calling_icon.show()
		$bark.set_wait_time(6)
		$bark.start()
		is_bark = true

func _on_bark_timeout():
	$calling_icon.hide()
	$bark_sound.stop()
	call_anim_player.stop()
	is_bark = false
