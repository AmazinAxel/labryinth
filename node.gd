extends Node

@export var health = 100
@export var lastDamageReason = ""

signal died

func _process(delta: float) -> void:
	if health <= 0:
		var deathMessage = "";
		if lastDamageReason == "barrel":
			deathMessage = "The barrel..?\nStaying in the barrel\nwill slowly kill you...\nGo out and back in to prevent death";
		elif lastDamageReason == "oscar":
			deathMessage = "Oscar got you.\nHe's not very kind to travellers like you!\nAttack him";
		elif lastDamageReason == "tristan":
			deathMessage = "You died to Tristan..\nWhen you see the blinks, enter a barrel...";
		elif lastDamageReason == "bob":
			deathMessage = "You died to Bob..\nThey're like Tristan, but be extra careful...\nThey come back thrice!";
		elif lastDamageReason == "timmy":
			deathMessage = "Timmy got you..\nClick the spider to swat at it..\notherwise it will eat away at your health!";
		elif lastDamageReason == "spikes":
			deathMessage = "The spikes..\nThe easiest hazard to avoid...\njust dont get trapped..";
		else:
			deathMessage = "How did you die?"
		died.emit(deathMessage)
