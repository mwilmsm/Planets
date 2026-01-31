extends Node3D

@export var accelVal = 10
@export var velocityDegrade = 0.95
@export var minVelocity = 0.01

var velocity = Vector3.ZERO

var rot_x = 0
var rot_y = 0

#func _ready():
	#$SunInstance.scale.x = 139.2
	#$SunInstance.scale.y = 139.2
	#$SunInstance.scale.z = 139.2


func _physics_process(_delta):
	pass

func _process(delta: float) -> void:
	handleCamera(delta)

	if (Input.is_action_pressed("escape")):
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rot_x -= event.screen_relative.x * 0.1
		rot_y -= event.screen_relative.y * 0.1
		$Camera3D.transform.basis = Basis()
		$Camera3D.rotate_object_local(Vector3.UP, rot_x)
		$Camera3D.rotate_object_local(Vector3.RIGHT, rot_y)

func handleCamera(delta: float) -> void:
	var acceleration = Vector3.ZERO
	if (Input.is_action_pressed("camera_back")):
		acceleration += $Camera3D.transform.basis.z
	if (Input.is_action_pressed("camera_forward")):
		acceleration += -$Camera3D.transform.basis.z
	if (Input.is_action_pressed("camera_up")):
		acceleration += $Camera3D.transform.basis.y
	if (Input.is_action_pressed("camera_down")):
		acceleration += -$Camera3D.transform.basis.y
	if (Input.is_action_pressed("camera_left")):
		acceleration += -$Camera3D.transform.basis.x
	if (Input.is_action_pressed("camera_right")):
		acceleration += $Camera3D.transform.basis.x

	acceleration = acceleration.normalized()
	velocity *= velocityDegrade
	velocity += acceleration * delta * accelVal

	if abs(velocity.x) < minVelocity:
		velocity.x = 0
	if abs(velocity.y) < minVelocity:
		velocity.y = 0
	if abs(velocity.z) < minVelocity:
		velocity.z = 0

	$Camera3D.position += velocity

	if get_node_or_null("Control/SunLabel") != null and get_node_or_null("CameraPivot/Camera3D") != null:
		$Control/SunLabel.text = str($CameraPivot/Camera3D.position)
		print("if")
