extends ColorRect

@onready var myNode = get_node('.');
@onready var myNode2 = $"."

# Called when the node enters the scene tree for the first time.
func diebg():
	myNode.show()
	myNode2.show()
	
