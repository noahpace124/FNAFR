extends CollisionShape2D

func _on_camera_pan_mouse_entered() -> void:
	Global.CameraPan -= Global.SPEED_CHANGE

func _on_camera_pan_mouse_exited() -> void:
	Global.CameraPan += Global.SPEED_CHANGE
