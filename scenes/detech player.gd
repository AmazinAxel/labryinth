extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name =="player body":
		var manager = get_node("../../../GameManager")
		manager.lastDamageReason = "oscar"
		manager.health-=10
