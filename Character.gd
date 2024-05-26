extends CharacterBody2D

signal hit_ball

const SPEED = 600.0
const JUMP_VELOCITY = -1500.0
const EXTRA_JUMPS = 1
const SWING_TIME = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = EXTRA_JUMPS
var swinging = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (Input.is_action_just_pressed("jump")) and jump_count > 0:
		velocity.y = JUMP_VELOCITY
		jump_count = jump_count - 1
	
	if (jump_count != EXTRA_JUMPS and is_on_floor()): jump_count = EXTRA_JUMPS
	
	if Input.is_action_pressed("duck") and velocity.y > 0:
		velocity.y *= 1.1
	
	if Input.is_action_just_pressed("swing"):
		var timer: SceneTreeTimer = get_tree().create_timer(SWING_TIME)
		swinging = true
		timer.timeout.connect(stop_swinging)

	if (swinging):
		trigger_hit()

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
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
	if (len(balls) > 0):
		balls[0].emit_signal("change_direction")
		swinging = false
