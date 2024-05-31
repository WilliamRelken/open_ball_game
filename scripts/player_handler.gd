extends Node

var players: Array[Player] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_player(id: int):
	for player in players:
		if (player.device == id):
			return true
	return false
