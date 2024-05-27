extends Button

@export var scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!scene):
		push_warning("SceneButton with no Node connected")

func _on_pressed():
	#var next_scene: Resource = load(scene)
	#next_scene.instance()
	get_tree().change_scene_to_file(scene.get_path())
	
