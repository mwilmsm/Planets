extends Node3D

func _physics_process(_delta):
	pass

func _process(delta: float) -> void:
	if (Input.is_action_pressed("escape")):
		get_tree().quit()

	if get_node_or_null("Control/SunLabel") != null and get_node_or_null("Camera3D") != null:
		$SunInstance/Control/SunLabel.text = str($Camera3D.position)
