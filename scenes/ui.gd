extends CanvasLayer

@onready var healthBar = $"health bar"
# Called when the node enters the scene tree for the first time.
func _ready():
	# Find the player node and connect to its signal.
	# This path might change depending on your scene tree structure.
	"""
	var player = get_node("../player/player body") 
	player.health_changed.connect(on_player_health_changed)
	"""
# This function will automatically run whenever the player emits the signal
func on_player_health_changed(new_health: int):
	healthBar.value = new_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(float) -> void:
	var gameManager = get_node("../GameManager")
	on_player_health_changed(gameManager.health)


func _on_game_manager_died(deathMessage: String) -> void:
	var deathReason = get_node("death/death reason")
	var deathBackground = get_node("death/background")
	deathReason.text = deathMessage;
	deathReason.show();
	deathBackground.show();
	get_node("death/deathtext").show()
