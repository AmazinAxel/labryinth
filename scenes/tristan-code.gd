extends CharacterBody2D

@export var goUp = false

func _process(_float: float) -> void:
	if goUp:
		global_position.y -= 5
