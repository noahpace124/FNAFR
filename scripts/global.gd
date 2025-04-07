extends Node

var next_scene = "res://scenes/loading.tscn"

var CameraCanPan = true
var CameraPan = 0

var SPEED_CHANGE = 4

var Night = 1

var Hour = 25.0

var DoorLeftClosed = false
var DoorRightClosed = false
var VentClosed = false
var CamerasUp = false
var DoorLeftWorks = true
var DoorRightWorks = true
var VentWorks = true

var LookingRight = false
var LookingLeft = false
var CamerasJustDown = false

var CameraView = 0

var IdlePowerDrain = 0.03
var CameraPowerDrain = 0.03
var DoorPowerDrain = 0.1
var VentPowerDrain = 0.1
var StartingPower = 100
var CurrentPower = 100
var HasPower = true

func initializeValues() -> void:
	Night = 1
	Hour = 25
	StartingPower = 100
	EnemyAI.enemies = []
	EnemyAI.inactive = [EnemyAI.Springy, EnemyAI.Lovely, EnemyAI.Sneaky, EnemyAI.Giggly, EnemyAI.Sleepy]
