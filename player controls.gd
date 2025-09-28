# Attach this script to your CharacterBody2D node.
extends CharacterBody2D

@export var speed = 300.0 # Max speed.
@export var acceleration = 10.0 # How quickly the player speeds up.
@export var friction = 10.0 # How quickly the player slows down.

signal health_changed(new_health)
signal died

var max_health: float = 100
var current_health: float = max_health

func _ready() -> void:
	velocity = Vector2.UP * 800

func _physics_process(delta):
	# This line is adjusted to match the simpler action names.
	var direction = Input.get_vector("left", "right", "up", "down")

	# The rest of the code remains the same.
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()

func take_damage(amount: float):
	print(current_health)
	current_health -= amount

	# Emit the signal and pass the new health value
	health_changed.emit(current_health)

	if current_health <= 0:
		get_tree().change_scene_to_file("res://death.tscn")
		died.emit()
		# Change scene text

func _on_area_2d_body_entered(body):
	print(body.name)

func _process(delta: float) -> void:
	#current_health -= delta*.5
	health_changed.emit(current_health)
	take_damage(1)
