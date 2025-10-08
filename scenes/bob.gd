extends CharacterBody2D

@export var direction = "static"

func _physics_process(_delta: float) -> void:
	if direction == "up":
		if self.get_node("bobNearby").playing == false:
			self.get_node("bobNearby").play()
			
		global_position.y -= 8
		
	elif direction == "down":
		
		if self.get_node("bobNearby").playing == false:
			self.get_node("bobNearby").play()
			
		global_position.y += 8
