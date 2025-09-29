extends CanvasLayer

@onready var timmy_sprite := $timmySprite
var spawn_timer := Timer.new()
var damage_timer := Timer.new()
var timmy_alive := false

func _ready():
	# Setup Timmy
	timmy_sprite.visible = false
	timmy_sprite.set_process_input(true)

	# Setup spawn timer
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	add_child(spawn_timer)

	_start_spawn_cycle()

func _start_spawn_cycle():
	var next_time = randf_range(10.0, 15.0)
	spawn_timer.start(next_time)

func _on_spawn_timer_timeout():
	_spawn_timmy()
	_start_spawn_cycle()

func _spawn_timmy():
	var screen_size = get_viewport().get_visible_rect().size
	var sprite_size = timmy_sprite.texture.get_size()

	var x = randf_range(0, screen_size.x - sprite_size.x)
	var y = randf_range(0, screen_size.y - sprite_size.y)
	timmy_sprite.position = Vector2(x, y)

	timmy_sprite.visible = true
	timmy_alive = true
	
	_start_damage_loop()
	

func _input(event):
	if timmy_alive and event is InputEventMouseButton and event.pressed:
		if timmy_sprite.get_rect().has_point(timmy_sprite.to_local(event.position)):
			_kill_timmy()

func _kill_timmy():
	timmy_alive = false
	timmy_sprite.visible = false

func _start_damage_loop() -> void:
	await get_tree().create_timer(2).timeout  # Initial delay
	while timmy_alive:
		var manager = get_node("/root/main/GameManager")
		manager.lastDamageReason = "timmy"
		manager.health -= 10
		await get_tree().create_timer(0.5).timeout
