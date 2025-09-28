extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		# Kill player if they're not in a barrel
		if !PlayerControls.inBarrel:
			var manager = get_node("../../../GameManager")
			manager.lastDamageReason = "tristan"
			manager.health-=100
