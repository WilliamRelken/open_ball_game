extends Control

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	%HealthBar.value = player.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%HealthBar.value = player.health
