extends Control

signal set_device_id(id: int)

@export var device_id: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (MultiplayerInput.is_action_just_pressed(device_id, "bunt")):
		if (%Ready.is_pressed()):
			%Ready.set_pressed(false)
		else:
			PlayerHandler.remove_player(device_id)
			self.queue_free()
	if (MultiplayerInput.is_action_just_pressed(device_id, "jump")):
		%Ready.set_pressed(true)

func _on_set_device_id(id: int):
	device_id = id
	%PlayerName.text = Input.get_joy_name(device_id)


func _on_ready_toggled(toggled_on):
	PlayerHandler.get_player(device_id).ready = toggled_on
