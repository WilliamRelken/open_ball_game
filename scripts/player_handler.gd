extends Node

const MAX_PLAYERS = 4
var players: Array[Player] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_player(id: int):
	if is_player(id) or players.size() >= MAX_PLAYERS:
		return
	var player = Player.new()
	player.device = id
	players.push_back(player)

func remove_player(id: int):
	for i in players.size():
		if (players[i].device == id):
			players.remove_at(i)
			return

func get_player(id: int) -> Player:
	for player in players:
		if player.device == id:
			return player
	return Player.new()

func set_player(player: Player):
	for i in players.size():
		if(players[i].device == player.device):
			players[i] = player

func is_player(id: int):
	for player in players:
		if (player.device == id):
			return true
	return false

func everyone_ready():
	if len(players) < 1:
		return false
	for player in players:
		if not player.ready:
			return false
	return true
