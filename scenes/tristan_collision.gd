extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var manager = get_node("/root/main/GameManager")
	if body.name == "player body":
		# Kill player if they're not in a barrel
		print(manager.inBarrel)
		if manager.inBarrel == false:
			manager.lastDamageReason = "tristan"
			manager.health -= 100
