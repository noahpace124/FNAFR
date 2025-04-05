extends Node

var next_scene = "res://scenes/loading.tscn"

var CameraCanPan = true
var CameraPan = 0

var SPEED_CHANGE = 4

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
