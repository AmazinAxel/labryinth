extends Area2D

var hasOscar:bool = false
var idx:int =0
var oscarObj
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var attacking = self.get_parent().isAttacking
	if hasOscar and attacking:
		oscarObj.takeDmg(1)
	if attacking:
		if (idx==5):
			sprite.visible = !(sprite.visible)
			idx=0
		else:
			idx+=1

func _on_body_entered(body: Node2D) -> void:
	if body.name =="player body":
		print('hit myself')
	elif (body.name =="oscar"):
		hasOscar = true
		oscarObj = body


func _on_body_exited(body: Node2D) -> void:
	if body.name=="oscar": # Replace with function body.
		hasOscar = false
		oscarObj=null
		
	
