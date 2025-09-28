extends Node

var health=50
signal died
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health2 ", health)
	if health <= 0:
		print('ahh dead')
		get_tree().change_scene_to_file("res://death.tscn")
		died.emit()
