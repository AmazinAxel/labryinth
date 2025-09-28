extends CharacterBody2D

var goUp = true
var target_y = 0

func tristan():
	goUp = true
		
	#print(goUp)
	#ddtarget_y = PlayerControls.global_position.y - 100



func _process(delta: float) -> void:
	if goUp:
		print("Moving up:", global_position.y)
		global_position.y -= 1
