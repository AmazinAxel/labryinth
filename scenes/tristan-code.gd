extends CharacterBody2D

@export var goUp = false

func _physics_process(_float: float) -> void:
	if goUp:
		if self.get_node("tristanNearby").playing == false:
			self.get_node("tristanNearby").play()
		global_position.y -= 5
