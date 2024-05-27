extends Control

signal set_device_id(id: int)

@export var device_id: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (MultiplayerInput.is_action_pressed(device_id, "bunt")):
		self.queue_free()

func _on_set_device_id(id: int):
	device_id = id
	%PlayerName.text = Input.get_joy_name(device_id)
