extends Control

const MAX_PLAYERS = 4
const MAX_BOX_WIDTH = 400
var player_devices: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var players = %PlayerList.get_children()
	var ready = PlayerHandler.everyone_ready()
	%ReadyBar.visible = ready
	for id in Input.get_connected_joypads():
		if (MultiplayerInput.is_action_just_pressed(id, "jump") and not PlayerHandler.is_player(id) and len(players) < PlayerHandler.MAX_PLAYERS):
			var new_player = load("res://scenes/menus/character_select/player_box/PlayerBox.tscn")
			var scene = new_player.instantiate()
			scene.set_device_id.emit(id)
			%PlayerList.add_child(scene)
			PlayerHandler.add_player(id)
		if ready and MultiplayerInput.is_action_just_pressed(id, "jump"):
			get_tree().change_scene_to_file("res://scenes/map/Map.tscn")
			return
	var box_count = %PlayerList.get_children().size()
	var window = get_viewport().get_visible_rect().size
	if (window.x < (box_count * MAX_BOX_WIDTH)):
		for scene: Control in %PlayerList.get_children():
			scene.custom_minimum_size.x = floori(window.x / box_count)
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main/Main.tscn")
