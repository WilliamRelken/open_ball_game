extends Control

const MAX_PLAYERS = 4
var player_devices: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var players = %PlayerList.get_children()
	for id in Input.get_connected_joypads():
		if (MultiplayerInput.is_action_just_pressed(id, "jump") and id not in player_devices and len(players) < MAX_PLAYERS):
			var new_player = load("res://scenes/menus/character_select/player_box/PlayerBox.tscn")
			var scene = new_player.instantiate()
			scene.set_device_id.emit(id)
			%PlayerList.add_child(scene)
	player_devices = get_players()

func get_players():
	var id_list: Array[int] = []
	var players = %PlayerList.get_children()
	for player in players:
		id_list.push_back(player.device_id)
	return id_list

func is_not_taken(player):
	return !player.device_selected

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main/Main.tscn")
