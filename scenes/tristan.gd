extends Node2D

@onready var tristan = $"../../../tristan/CharacterBody2D";

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		tristan.goUp = true;
		tristan.global_position.y = PlayerControls.global_position.y + 1000
		get_node("/root/main/tristanBlink").show()
		await get_tree().create_timer(0.05).timeout
		
		get_node("/root/main/tristanBlink").hide()
		await get_tree().create_timer(0.1).timeout
		
		get_node("/root/main/tristanBlink").show()
		await get_tree().create_timer(0.2).timeout

		get_node("/root/main/tristanBlink").hide()
