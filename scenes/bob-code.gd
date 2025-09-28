extends Node2D

@onready var tristan = $"../../../tristan/CharacterBody2D";

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		tristan.goUp = "up";
		tristan.global_position.y = PlayerControls.global_position.y + 1000
		
		get_node("/root/main/bobBlink").show()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/bobBlink").hide()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/bobBlink").show()
		await get_tree().create_timer(0.3).timeout

		get_node("/root/main/bobBlink").hide()

		await get_tree().create_timer(5).timeout
		tristan.goUp = "down";
		await get_tree().create_timer(5).timeout
		tristan.goUp = "up";
		await get_tree().create_timer(5).timeout
		tristan.goUp = "down";


		tristan.global_position.y = 1000
