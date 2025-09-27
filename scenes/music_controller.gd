extends Node

@onready var audio:AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.stream = preload("res://assets/ambient.mp3")
	audio.play()
