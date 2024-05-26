extends CharacterBody2D

signal change_direction

var direction: Vector2
var SPEED = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(1,1).rotated(deg_to_rad(randi_range(0,359))) * SPEED

func _process(delta):
	var spd = SPEED
	velocity = direction
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D):
	var path = str(body.get_path())
	if (path == "/root/Map/Arena/WallLeft" or path == "/root/Map/Arena/WallRight"):
		direction.x *= -1
	elif (path == "/root/Map/Arena/Floor" or path == "/root/Map/Arena/Ceiling"):
		direction.y *= -1


func _on_change_direction():
	direction.x *= -1
	direction.y *= -1
