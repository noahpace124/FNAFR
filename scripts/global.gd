extends Node

var CameraPan = 0

var SPEED_CHANGE = 4

var DoorLeftClosed = false
var DoorRightClosed = false
var VentClosed = false
var CamerasUp = false

var LookingRight = false
var LookingLeft = false

var CameraView = 0

var IdlePowerDrain = 0.03
var CameraPowerDrain = 0.03
var DoorPowerDrain = 0.1
var VentPowerDrain = 0.1
var CurrentPower = 100
var HasPower = true
