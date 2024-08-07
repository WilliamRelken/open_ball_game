extends CharacterBody2D

signal hit_ball

const SPEED = 600.0
const JUMP_VELOCITY = -1500.0
const EXTRA_JUMPS = 1
const SWING_TIME = 0.2
const SWING_MULT = 1.1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var device_id: int
var player: Player
var jump_count = EXTRA_JUMPS
var swinging = false
var swing_dir: Vector2 = Vector2(0, 0)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if device_id >= 0:
		if (MultiplayerInput.is_action_just_pressed(device_id, "jump")) and jump_count > 0:
			velocity.y = JUMP_VELOCITY
			jump_count = jump_count - 1
		
		if (jump_count != EXTRA_JUMPS and is_on_floor()): jump_count = EXTRA_JUMPS
		
		if MultiplayerInput.is_action_just_pressed(device_id, "swing"):
			var move_dir: Vector2 = MultiplayerInput.get_vector(device_id, "move_left", "move_right", "look_up", "duck")
			swing_dir = move_dir
			var timer: SceneTreeTimer = get_tree().create_timer(SWING_TIME)
			swinging = true
			timer.timeout.connect(stop_swinging)

	if (swinging):
		trigger_hit()

	var direction = MultiplayerInput.get_axis(device_id, "move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * 1.5
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func stop_swinging():
	swinging = false

func is_ball(node: Node2D):
	return node.has_signal("change_direction")
func trigger_hit():
	var bodies = %BatterBox.get_overlapping_bodies()
	var balls: Array[Node2D] = bodies.filter(is_ball)
	var mult = 1
	if (swing_dir.y > 0):
		mult = SWING_MULT
	for ball in balls:
		ball.emit_signal("change_direction", swing_dir, mult)
		swinging = false
