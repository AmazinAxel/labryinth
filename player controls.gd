# Attach this script to your CharacterBody2D node.
extends CharacterBody2D

@export var speed = 300.0 # Max speed.
@export var acceleration = 10.0 # How quickly the player speeds up.
@export var friction = 10.0 # How quickly the player slows down.

signal health_changed(new_health)
signal died

var max_health: int = 100
var current_health: int = max_health

func _physics_process(delta):
	# This line is adjusted to match the simpler action names.
	var direction = Input.get_vector("left", "right", "up", "down")

	# The rest of the code remains the same.
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()
	
func take_damage(amount: int):
	current_health -= amount
	current_health = max(0, current_health) # Prevent health from going below 0

	# Emit the signal and pass the new health value
	health_changed.emit(current_health)

	if current_health <= 0:
		died.emit()
	# queue_free() or other death logic

func _process(delta: float) -> void:
	current_health -= delta*.5
	health_changed.emit(current_health)
