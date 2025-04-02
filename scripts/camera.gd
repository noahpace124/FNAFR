extends Camera2D

var MIN_X = 0
var MAX_X = 220

func _process(_delta: float) -> void:
	if !Global.CamerasUp:
		offset.x += Global.CameraPan
		if offset.x < MIN_X:
			offset.x = MIN_X
		elif offset.x > MAX_X:
			offset.x = MAX_X
