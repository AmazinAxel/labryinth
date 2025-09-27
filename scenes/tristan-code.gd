extends Node2D

var goUp = false
var target_y = 0

func tristan():
	print(self)
	goUp = true
	target_y = PlayerControls.global_position.y - 100

func _physics_process(delta: float) -> void:
	if goUp:
		global_position.y -= 1
		if global_position.y <= target_y:
			goUp = false
		print(global_position.y)
