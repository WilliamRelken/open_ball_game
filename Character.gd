extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -800.0
const EXTRA_JUMPS = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = EXTRA_JUMPS


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and jump_count > 0:
		velocity.y = JUMP_VELOCITY
		jump_count = jump_count - 1
		print(jump_count)
	
	if (jump_count != EXTRA_JUMPS and is_on_floor()): jump_count = EXTRA_JUMPS

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
