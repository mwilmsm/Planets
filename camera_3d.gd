extends Camera3D

@export var accelVal = 10
@export var speedMultiplier = 5
@export var velocityDegrade = 0.95
@export var minVelocity = 0.01

var velocity = Vector3.ZERO

var rot_x = 0
var rot_y = 0


func _process(delta: float) -> void:
	handleCamera(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rot_x -= event.screen_relative.x * 0.1
		rot_y -= event.screen_relative.y * 0.1
		transform.basis = Basis()
		rotate_object_local(Vector3.UP, rot_x)
		rotate_object_local(Vector3.RIGHT, rot_y)

func handleCamera(delta: float) -> void:
	var acceleration = Vector3.ZERO
	if (Input.is_action_pressed("camera_back")):
		acceleration += transform.basis.z
	if (Input.is_action_pressed("camera_forward")):
		acceleration += -transform.basis.z
	if (Input.is_action_pressed("camera_up")):
		acceleration += transform.basis.y
	if (Input.is_action_pressed("camera_down")):
		acceleration += -transform.basis.y
	if (Input.is_action_pressed("camera_left")):
		acceleration += -transform.basis.x
	if (Input.is_action_pressed("camera_right")):
		acceleration += transform.basis.x

	acceleration = acceleration.normalized()
	if (Input.is_action_pressed("speed_up")):
		acceleration *= speedMultiplier
	velocity *= velocityDegrade

	velocity += acceleration * delta * accelVal

	if abs(velocity.x) < minVelocity:
		velocity.x = 0
	if abs(velocity.y) < minVelocity:
		velocity.y = 0
	if abs(velocity.z) < minVelocity:
		velocity.z = 0

	position += velocity
