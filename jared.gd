extends Sprite2D

var left_x = -400
var right_x = 400
var speed = 100.0  # pixels per second
var direction = 1  # 1 = right, -1 = left

func _ready():
	position.x = left_x
	position.y = -500

func _process(delta):
	position.x += direction * speed * delta
	position.y = -500
	
	if direction == 1 and position.x >= right_x:
		position.x = right_x
		direction = -1
	elif direction == -1 and position.x <= left_x:
		position.x = left_x
		direction = 1
