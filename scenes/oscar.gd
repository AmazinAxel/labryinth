extends CharacterBody2D

## The speed of the monster in pixels wper second.
@export var speed: float = 100.0
## The distance in pixels at which the monster will detect and chase the player.
@export var detection_range: float = 150.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance = global_position.distance_to(PlayerControls.global_position)
	#print(distance)
	# --- MODIFIED LOGIC ---
	# We check if the player is in range BUT ALSO not too close.
	if distance < detection_range:
	
		var direction = (PlayerControls.global_position - global_position).normalized()
		global_position += direction * speed * delta
