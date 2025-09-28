extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		get_node("/root/main/ui/win").show();
		get_node("/root/main/GameManager").inBarrel = true;
