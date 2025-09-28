# Attach this script to your CharacterBody2D node.
extends CharacterBody2D

@export var speed = 100.0 # Max speed.
@export var acceleration = 50.0 # How quickly the player speeds up.
@export var friction = 30.0 # How quickly the player slows down.
@export var inBarrel = false

signal health_changed(new_health)

@export var max_health: float = 100
@export var current_health: float = max_health

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
	
	if inBarrel == true:
		velocity = Vector2.ZERO
	
	check_for_spikes()
	move_and_slide()
	
func _unhandled_input(event):
	if event.is_action_pressed("release_lock"):
		check_for_barrel()
		
func check_for_barrel():
	var map = get_node("/root/main/Map")
	var tileMap = map.get_node("Objects")
	var coords = tileMap.local_to_map(global_position)
	var tile = tileMap.get_cell_source_id(coords)
	if tile != -1: # tile isnt nil
		var tile_data = tileMap.get_cell_tile_data(coords)
		
		if tile_data:
			
			var isBarrelType = tile_data.get_custom_data("isBarrelType")
			
			if isBarrelType == true:
				if inBarrel == false:
					var center = tileMap.map_to_local(coords)
					global_position = center
					inBarrel = true
					self.visible = false
					
				else:
					self.visible = true
					inBarrel = false

func check_for_spikes():
	var map = get_node("/root/main/Map")
	var tileMap = map.get_node("Objects")
	var coords = tileMap.local_to_map(global_position)
	var tile = tileMap.get_cell_source_id(coords)
	if tile != -1: # tile isnt nil
		var tile_data = tileMap.get_cell_tile_data(coords)
		
		if tile_data:
			if tile_data.get_custom_data("isSpikeType"):
				var manager = get_node("/root/main/GameManager")
				manager.lastDamageReason = "spikes"
				manager.health =- 10

#func take_damage(amount: float):
	#current_health -= amount

	# Emit the signal and pass the new health value
	#health_changed.emit(current_health)

#	if current_health <= 0:
		
#		died.emit()
		# Change scene text


#func _process(delta: float) -> void:
	#current_health -= delta*.5
	#health_changed.emit(current_health)
	#take_damage(.01)
