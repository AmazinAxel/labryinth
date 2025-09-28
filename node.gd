extends Node

var health = 100
signal died

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		get_tree().change_scene_to_file("res://death.tscn")
		died.emit()
