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
	if offset.x <= 163: #Farthest right before can't see door
		Global.LookingLeft = true
	else:
		Global.LookingLeft = false
	if offset.x >= 82: #farthest left before can't see door
		Global.LookingRight = true
	else: 
		Global.LookingRight = false
