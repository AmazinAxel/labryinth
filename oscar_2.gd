extends CharacterBody2D

@export var speed: float = 90.0
@export var detection_range: float = 100.0

@export var health:float =70
var player: Sprite2D

func _ready() -> void:
	# Adjust this path to match your actual scene tree
	player = get_node("/root/main/player/player body/Sprite2D")

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	if not player:
		return;
	var distance = global_position.distance_to(player.global_position)

	if distance < detection_range:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func takeDmg(val: float):
	health-=val
