extends CharacterBody2D

@export var direction = "static"

func _physics_process(_delta: float) -> void:
	if direction == "up":
		global_position.y -= 8
	elif direction == "down":
		global_position.y += 8
