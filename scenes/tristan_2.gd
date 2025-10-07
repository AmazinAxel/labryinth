extends Node2D

var thisStage = 2;

func _on_body_entered(body: Node2D) -> void:
	var tristan = $"../../../tristan/CharacterBody2D";
	var manager = get_node("/root/main/GameManager")
	
	if body.name == "player body":
		if manager.gameStage >= thisStage:
			return
		
		manager.gameStage = thisStage;
		print(thisStage)
		tristan.goUp = true;
		tristan.global_position.y = PlayerControls.global_position.y + 1000
						
		get_node("/root/main/tristanBlink").show()
		await get_tree().create_timer(0.05).timeout
		
		get_node("/root/main/tristanBlink").hide()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/tristanBlink").show()
		await get_tree().create_timer(0.2).timeout

		get_node("/root/main/tristanBlink").hide()

		await get_tree().create_timer(5).timeout
		tristan.goUp = false;
		tristan.global_position.y = 1000
