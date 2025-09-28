extends Node

var health = 10
var lastDamageReason = ""

signal died

func _process(delta: float) -> void:
	if health <= 0:
		var deathMessage = "";
		if lastDamageReason == "barrel":
			deathMessage = "Staying in the barrel will slowly kill you...\nGo outside and back to prevent death";
		elif lastDamageReason == "oscar":
			deathMessage = "Oscar got you. He's not very kind to travellers like you!\nAttack him";
		elif lastDamageReason == "tristan":
			deathMessage = "You died to Tristan..\nWhen you see the blinks, enter a barrel...";
		elif lastDamageReason == "bob":
			deathMessage = "You died to Bob..\nThey're like Tristan, but be extra careful...\nThey come back thrice!";
		elif lastDamageReason == "timmy":
			deathMessage = "Timmy got you..\nClick the spider to swat it - otherwise it will eat away at your health!";
		elif lastDamageReason == "spikes":
			deathMessage = "The spikes..\nThe easiest hazard to avoid... just dont get trapped..";
		else:
			deathMessage = "How did you die?"
		died.emit(deathMessage)
