extends Button

func _on_pressed() -> void:
	#print("try again")
	get_tree().reload_current_scene()
