extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for player in PlayerHandler.players:
		var scene = load("res://scenes/health_bars/single/single.tscn").instantiate()
		add_child(scene)
		scene.player = player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
