extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var players = PlayerHandler.players
	var split_players = split_players_by_even(players)
	add_players_to_line(split_players.get("even"), %Spawns/SpawnLineEven)
	add_players_to_line(split_players.get("odd"), %Spawns/SpawnLineOdd)

func add_players_to_line(players: Array[Player], line: Path2D):
	for i in players.size():
		var point = PathFollow2D.new()
		point.progress_ratio = i / players.size()
		line.add_child(point)
		var scene = load("res://scenes/character/Character.tscn")
		var player: Player = players[i]
		var player_scene = scene.instantiate()
		player_scene.device_id = player.device
		player_scene.position = point.global_position
		add_child(player_scene)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func split_players_by_even(players: Array[Player]):
	var even: Array[Player] = []
	var odd: Array[Player] = []
	for i in players.size():
		if is_even(i):
			even.push_back(players[i])
		else:
			odd.push_back(players[i])
	return { "even": even, "odd": odd}

# I should not have to do this godot -_-
func is_even(x: int):
	return x % 2 == 0
