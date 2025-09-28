extends CharacterBody2D

@export var goUp = false
var target_y = 0


func _process(delta: float) -> void:
	if goUp:
		print("Moving up:", global_position.y)
		global_position.y -= 1
