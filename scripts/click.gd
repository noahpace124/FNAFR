extends Sprite2D

@onready var night_node = get_tree().get_root().get_node("Night")
@onready var SFX = night_node.get_node("GUI/EnemySFX")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_pixel_opaque(get_local_mouse_position()):
				if name.contains("Sleepy"):
					EnemyAI.Sleepy["Location"] = -1
					SFX.stream = preload("res://assets/audio/Click.wav")
					SFX.play()
