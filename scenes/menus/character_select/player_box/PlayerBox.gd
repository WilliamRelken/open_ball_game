extends Control

signal set_device_id(id: int)

@export var device_id: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_set_device_id(id: int):
	device_id = id
	%PlayerName.text = Input.get_joy_name(device_id)
