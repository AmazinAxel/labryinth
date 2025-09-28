extends Area2D

var touchingPlayer: bool = false
func _on_body_entered(body: Node2D) -> void:
	if body.name =="player body":
		touchingPlayer= true
		var manager = get_node("../../../GameManager")
		manager.lastDamageReason = "oscar"
		manager.health-=10


func _on_body_exited(body: Node2D) -> void:
	if body.name=="player body":
		touchingPlayer = false
	
func _process(delta: float) -> void:
	if (touchingPlayer):
		var manager = get_node("../../../GameManager")
		manager.lastDamageReason = "oscar"
		manager.health-=.1
