# Attach this script to your CharacterBody2D node.
extends CharacterBody2D

# Exporting the variable allows you to edit it in the Inspector.
@export var speed = 300 # Player speed in pixels/sec.

func _physics_process(delta):
	# This gets a vector representing the player's input direction.
	# It checks the Input Map actions we set up ("move_left", "move_right", etc.)
	# The vector is automatically normalized, so diagonal movement isn't faster.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Set the velocity based on the input direction and speed.
	velocity = direction * speed

	# move_and_slide() is a built-in CharacterBody2D function that moves the
	# body along its velocity vector and handles collisions. It makes the
	# player slide along walls instead of stopping abruptly.
	move_and_slide()
