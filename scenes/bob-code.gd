extends Node2D

var thisStage = 4;

func _on_body_entered(body: Node2D) -> void:
	var bob = $"../../../bob";
	var manager = get_node("/root/main/GameManager")
	
	if body.name == "player body":
		if manager.gameStage >= thisStage:
			return
		
		manager.gameStage = thisStage;
		print(thisStage)
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
