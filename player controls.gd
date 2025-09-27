# Attach this script to your CharacterBody2D node.
extends CharacterBody2D

@export var speed = 300.0 # Max speed.
@export var acceleration = 10.0 # How quickly the player speeds up.
@export var friction = 10.0 # How quickly the player slows down.

func _physics_process(delta):
	# This line is adjusted to match the simpler action names.
	var direction = Input.get_vector("left", "right", "up", "down")

	# The rest of the code remains the same.
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()
