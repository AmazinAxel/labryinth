extends CanvasLayer

@onready var timmy := $timmySprite
var spawn_timer := Timer.new()
var damage_timer := Timer.new()
var timmy_alive := false

func _ready() -> void:
	# Setup Timmy
	timmy.visible = false
	timmy.set_process_input(true)

	# Setup spawn timer
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	add_child(spawn_timer)

	# Setup damage timer
	damage_timer.one_shot = true
	damage_timer.connect("timeout", Callable(self, "_on_damage_timeout"))
	add_child(damage_timer)

	_start_spawn_cycle()

func _start_spawn_cycle():
	var next_time = randf_range(1.0, 2.0)
	spawn_timer.start(next_time)

func _on_spawn_timer_timeout():
	_spawn_timmy()
	_start_spawn_cycle()

func _spawn_timmy():
	var screen_size = get_viewport().get_visible_rect().size
	var sprite_size = timmy.texture.get_size()

	var x = randf_range(0, screen_size.x - sprite_size.x)
	var y = randf_range(0, screen_size.y - sprite_size.y)
	timmy.position = Vector2(x, y)

	timmy.visible = true
	timmy_alive = true
	damage_timer.start(5.0)
	print("Timmy spawned at ", timmy.position)

func _input(event):
	if timmy_alive and event is InputEventMouseButton and event.pressed:
		if timmy.get_rect().has_point(timmy.to_local(event.position)):
			_kill_timmy()

func _kill_timmy():
	timmy_alive = false
	timmy.visible = false
	damage_timer.stop()
	print("Timmy clicked — no damage!")

func _on_damage_timeout():
	if timmy_alive:
		timmy_alive = false
		timmy.visible = false
		print("Timmy timed out — damage applied!")
		#get_tree().call_group("player", "apply_damage", 10)
