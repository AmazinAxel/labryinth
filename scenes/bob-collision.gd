extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		var manager = get_node("../../GameManager")
		# Kill player if they're not in a barrel
		if manager.inBarrel == false:
			manager.lastDamageReason = "bob"
			manager.health-=100
