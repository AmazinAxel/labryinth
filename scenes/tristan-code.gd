extends CharacterBody2D

@export var goUp = false

func _process(delta: float) -> void:
	if goUp:
		global_position.y -= 5
