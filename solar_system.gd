extends Node3D

@export var accelVal = 10
@export var velocityDegrade = 0.95
@export var minVelocity = 0.01

var velocity = Vector3.ZERO

func _physics_process(_delta):
	pass

func _process(delta: float) -> void:
	handleCamera(delta)

	if (Input.is_action_pressed("escape")):
		get_tree().quit()

func handleCamera(delta: float) -> void:
	var acceleration = Vector3.ZERO
	if (Input.is_action_pressed("camera_back")):
		acceleration += Vector3.BACK
	if (Input.is_action_pressed("camera_forward")):
		acceleration += Vector3.FORWARD
	if (Input.is_action_pressed("camera_up")):
		acceleration += Vector3.UP
	if (Input.is_action_pressed("camera_down")):
		acceleration += Vector3.DOWN
	if (Input.is_action_pressed("camera_left")):
		acceleration += Vector3.LEFT
	if (Input.is_action_pressed("camera_right")):
		acceleration += Vector3.RIGHT

	acceleration = acceleration.normalized()
	velocity *= velocityDegrade
	velocity += acceleration * delta * accelVal

	if abs(velocity.x) < minVelocity:
		velocity.x = 0
	if abs(velocity.y) < minVelocity:
		velocity.y = 0
	if abs(velocity.z) < minVelocity:
		velocity.z = 0

	$CameraPivot/Camera3D.position += velocity
	print("Velocity: " + str(velocity))
	print("Position: " + str($CameraPivot/Camera3D.position))

	#$Control/Label.text = str($CameraPivot/Camera3D.position)
