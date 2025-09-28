extends Node2D

@onready var tristan = $"../../../tristan/CharacterBody2D";

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player body":
		tristan.goUp = true;
		#target_y = PlayerControls.global_position.y - 100
