extends Node

var CameraPositionYMin = 200
var CameraPositionYMax = 600
var CameraSpeed = 40

var JumpscareMinY = 200
var JumpscareShake = 20

var rng = RandomNumberGenerator.new()

var SpringyLastLocation = 0
var SpringyLocation = 0
var SpringyAI = 16

var SpringyWait = 0.0
func SpringyMoveCheck() -> void:
	SpringyWait += 0.1
	if SpringyWait >= 4.7:
		print("Springy gets Impatient")
		var num = rng.randi_range(1, 20)
		if num <= SpringyAI:
			SpringyMove()
		SpringyWait = 0
func SpringyMove() -> void:
	if SpringyLocation == 0: #
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 2
			print("Springy moves to Cam 3")
		else:
			SpringyLocation = 5
			print("Springy moves to Cam 6")
	elif SpringyLocation == 2:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 3
			print("Springy moves to Cam 4")
		else:
			SpringyLocation = 5
			print("Springy moves to Cam 6")
	elif SpringyLocation == 3:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 2
			print("Springy moves to Cam 3")
		else:
			SpringyLocation = 8
			print("Springy moves to Cam 9")
	elif SpringyLocation == 5:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 2
			print("Springy moves to Cam 3")
		else:
			SpringyLocation = 7
			print("Springy moves to Cam 8")
	elif SpringyLocation == 7:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 8
			print("Springy moves to Cam 9")
		else:
			SpringyLocation = 12
			print("Springy moves to Cam 13")
	elif SpringyLocation == 8:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 7
			print("Springy moves to Cam 8")
		else:
			SpringyLocation = 12
			print("Springy moves to Cam 13")
	elif SpringyLocation == 12:
		var change = rng.randf()
		if change < 0.5: #50/50
			SpringyLocation = 7
			print("Springy moves to Cam 8")
		else:
			SpringyLocation = 15
			print("Springy moves to the Office")
	elif SpringyLocation == 15:
		if !Global.DoorLeftClosed:
			SpringyLocation = 16
			print("Springy is in Position")
		else:
			SpringyLocation = 0
			print("Springy moves to Cam 1")
