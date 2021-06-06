extends Node

signal no_health

var max_health = 100
onready var health = max_health setget set_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
