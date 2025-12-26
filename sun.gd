extends Node3D


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	pass
	print("on screen")
	$"Control/SunLabel".visible = true


func _on_visible_on_screen_enabler_3d_screen_exited() -> void:
	pass
	print("off screen")
	$"Control/SunLabel".visible = false
