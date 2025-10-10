extends CharacterBody2D

@export var speed: float = 100.0
@export var acceleration: float = 50.0
@export var friction: float = 30.0
@export var inBarrel: bool = false
@export var facingRight:bool = true
@export var isAttacking: bool = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		if has_node("WalkingSound"):
			if get_node("WalkingSound").playing == false:
				get_node("WalkingSound").play()
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
		
		if has_node("WalkingSound"):
			if get_node("WalkingSound").playing == true:
				get_node("WalkingSound").stop()
	
	if direction.x!=0:
		var sprites = self.get_children()
		if len(sprites) > 0:
			var sprite = self.get_node("Sprite2D")
			sprite.flip_h = direction.x < 0
			facingRight = direction.x < 0
			var hurtShape = get_node("./hurtBox").get_child(0)
			
			if facingRight:
				hurtShape.position.x =-27
			else:
				hurtShape.position.x=-3
	
	#print(direction.x)
	
	if has_node("/root/main/GameManager"):
		var manager = get_node("/root/main/GameManager")
		if manager.inBarrel:
			velocity = Vector2.ZERO
			manager.lastDamageReason = "barrel"
			manager.health -= 0.05
			
	else:
		return
	

	check_for_spikes()
	check_for_healthPotion()
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_lock"):
		toggle_barrel_state()
	if event.is_action_pressed("attack") and not isAttacking:
		attack()

func attack():
	if (self.name == "player body"):
		var manager = get_node("/root/main/GameManager")
		manager.lastDamageReason = "attack"
		manager.health -= 5
		isAttacking = true
		self.get_node("DamageSound").play()
		var timer = get_node("Timer");
		timer.start()

		
func toggle_barrel_state() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	var local_pos = tileMap.to_local(global_position)
	var coords = tileMap.local_to_map(local_pos)
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
				if self.get_node("PickupSound"):
					self.get_node("PickupSound").play()

func check_for_spikes() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	if tileMap:
		var coords = tileMap.local_to_map(global_position)
		var tile = tileMap.get_cell_source_id(coords)
		

		if tile != -1:
			var tile_data = tileMap.get_cell_tile_data(coords)
			if tile_data and tile_data.get_custom_data("isSpikeType"):
				var tile_local_pos = tileMap.map_to_local(coords)
				var tile_global_pos = tileMap.to_global(tile_local_pos)
			
				var distance = global_position.distance_to(tile_global_pos)
				print(distance)
			
				if distance <= 5:
					
					var manager = get_node("/root/main/GameManager")
					manager.lastDamageReason = "spikes"
					manager.health -= 50;
						
					print("spikes??")
						
					if self.has_node("../SpikeActivated"):
						self.get_node("../SpikeActivated").play()
						
					tileMap.set_cell(coords, 4, Vector2i(0, 0))

func check_for_healthPotion() -> void:
	var tileMap = get_node("/root/main/Map/Objects")
	if tileMap:
		var coords = tileMap.local_to_map(global_position)
		var tile = tileMap.get_cell_source_id(coords)

		if tile != -1:
			var tile_data = tileMap.get_cell_tile_data(coords)
			if tile_data and tile_data.get_custom_data("isHealthPotionType"):
				var manager = get_node("/root/main/GameManager")
				
				manager.health += 50
				if manager.health > 100:
					manager.health = 100
				
				if self.get_node("PickupSound"):
					self.get_node("PickupSound").play()
					
				tileMap.set_cell(coords, -1)


func _on_timer_timeout() -> void:
	isAttacking=false # Replace with function body.
	var attackSprite = get_node("hurtBox/CollisionShape2D/Sprite2D")
	attackSprite.visible = false
