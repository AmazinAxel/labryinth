extends Node2D

@onready var bob = $"../../../bob";

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		bob.direction = "up";
		bob.global_position.y = PlayerControls.global_position.y + 1000
		
		get_node("/root/main/bobBlink").show()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/bobBlink").hide()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/bobBlink").show()
		await get_tree().create_timer(0.3).timeout

		get_node("/root/main/bobBlink").hide()

		await get_tree().create_timer(4).timeout
		bob.direction = "down";

		await get_tree().create_timer(4).timeout
		bob.direction = "up";

		await get_tree().create_timer(4).timeout
		bob.direction = "down";
		bob.global_position.y = 1000
