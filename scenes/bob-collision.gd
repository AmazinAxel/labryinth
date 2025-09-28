extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		# Kill player if they're not in a barrel
		print(PlayerControls.inBarrel)
		if PlayerControls.inBarrel == false:
			var manager = get_node("../../../GameManager")
			manager.lastDamageReason = "bob"
			manager.health-=100
