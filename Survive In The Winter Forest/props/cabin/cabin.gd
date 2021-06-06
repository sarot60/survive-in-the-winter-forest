extends StaticBody2D


func _ready():
	var _Con1 = $Area2D.connect("body_entered", self, "hide_roof")
	var _Con2 = $Area2D.connect("body_exited", self, "show_roof")

func show_roof(body):
	if body.name == "player":
		$graphics/roof.show()

func hide_roof(body):
	if body.name == "player":
		$graphics/roof.hide()
