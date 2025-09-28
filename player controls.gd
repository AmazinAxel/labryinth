extends CharacterBody2D

@export var speed: float = 100.0
@export var acceleration: float = 50.0
@export var friction: float = 30.0
@export var inBarrel: bool = false
@export var facingRight:bool = true
@export var isAttacking: bool = false

@onready var hurtBox = $hurtBox
@onready var timer = $Timer

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	if direction.x!=0:
		var sprites = self.get_children()
		if len(sprites) > 0:
			var sprite = self.get_node("Sprite2D")
			sprite.flip_h = direction.x < 0
			facingRight = direction.x < 0
			var hurtShape = hurtBox.get_child(0)
			
			if facingRight:
				hurtShape.position.x =-30.5
			else:
				hurtShape.position.x=0
	
	#print(direction.x)
	var manager = get_node("/root/main/GameManager")
	if manager.inBarrel:
		velocity = Vector2.ZERO

	check_for_spikes()
	check_for_healthPotion()
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_lock"):
		toggle_barrel_state()
	if event.is_action_pressed("attack") and not isAttacking:
		attack()


func attack():
	
	# print(get_node("/root/main").get_children())
	if (self.name == "player body"):
		isAttacking = true
		print(self)
		timer.start()
		print('starting timer')

		
func toggle_barrel_state() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	var coords = tileMap.local_to_map(global_position)
	var tile = tileMap.get_cell_source_id(coords)

	if tile != -1:
		var tile_data = tileMap.get_cell_tile_data(coords)
		if tile_data:
			var isBarrelType = tile_data.get_custom_data("isBarrelType")
			if isBarrelType:
				var center = tileMap.map_to_local(coords)
				var manager = get_node("/root/main/GameManager")
				global_position = center
				manager.inBarrel = !manager.inBarrel
				visible = !manager.inBarrel
				#self.get_node("EnterBarrelSound").play()

func check_for_spikes() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	var coords = tileMap.local_to_map(global_position)
	var tile = tileMap.get_cell_source_id(coords)

	if tile != -1:
		var tile_data = tileMap.get_cell_tile_data(coords)
		if tile_data and tile_data.get_custom_data("isSpikeType"):
			var manager = get_node("/root/main/GameManager")
			manager.lastDamageReason = "spikes"
			#self.get_node("DamageSound").play()
			manager.health -= 10;
			
func check_for_healthPotion() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	var coords = tileMap.local_to_map(global_position)
	var tile = tileMap.get_cell_source_id(coords)

	if tile != -1:
		var tile_data = tileMap.get_cell_tile_data(coords)
		if tile_data and tile_data.get_custom_data("isHealthPotionType"):
			var manager = get_node("/root/main/GameManager")
			
			manager.health += 20;
			#self.get_node("PickupSound").play()
			tileMap.set_cell(coords, -1)


func _on_timer_timeout() -> void:
	isAttacking=false # Replace with function body.
	print("we're done")
