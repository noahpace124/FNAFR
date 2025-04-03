extends Node

var CameraPositionYMin = 200
var CameraPositionYMax = 600
var CameraSpeed = 40

var JumpscareMinY = 200
var JumpscareShake = 20

var rng = RandomNumberGenerator.new()

var Springy = {
	"Name": "Springy",
	"LastLocation": 0,
	"Location": -1,
	"AI": 16,
	"Wait": 0.0,
	"Act": 4.7
}

var enemies = []

func InitializeEnemies() -> void:
	for enemy in enemies:
		enemy["Location"] = enemy["LastLocation"]

func MoveCheck() -> void:
	for enemy in enemies:
		enemy["Wait"] += 0.1
		if enemy["Wait"] >= enemy["Act"]:
			print(enemy["Name"] + " gets Impatient")
			var num = rng.randi_range(1, 20)
			if num <= enemy["AI"]:
				if enemy["Name"] == "Springy":
					SpringyMove()
			enemy["Wait"] = 0.0

func GetEnemyByName(name: String) -> Dictionary:
	for enemy in enemies:
		if enemy["Name"] == name:
			return enemy
	return {}

func SpringyMove() -> void:
	var Springy = GetEnemyByName("Springy")
	if Springy["Location"] == 0: #
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 2
			print("Springy moves to Cam 3")
		else:
			Springy["Location"] = 5
			print("Springy moves to Cam 6")
	elif Springy["Location"] == 2:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 3
			print("Springy moves to Cam 4")
		else:
			Springy["Location"] = 5
			print("Springy moves to Cam 6")
	elif Springy["Location"] == 3:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 2
			print("Springy moves to Cam 3")
		else:
			Springy["Location"] = 8
			print("Springy moves to Cam 9")
	elif Springy["Location"] == 5:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 2
			print("Springy moves to Cam 3")
		else:
			Springy["Location"] = 7
			print("Springy moves to Cam 8")
	elif Springy["Location"] == 7:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 8
			print("Springy moves to Cam 9")
		else:
			Springy["Location"] = 12
			print("Springy moves to Cam 13")
	elif Springy["Location"] == 8:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 7
			print("Springy moves to Cam 8")
		else:
			Springy["Location"] = 12
			print("Springy moves to Cam 13")
	elif Springy["Location"] == 12:
		var change = rng.randf()
		if change < 0.5: #50/50
			Springy["Location"] = 7
			print("Springy moves to Cam 8")
		else:
			if Global.CamerasUp or !Global.LookingLeft:
				Springy["Location"] = 15
				print("Springy moves to the Office")
	elif Springy["Location"] == 15:
		if !Global.DoorLeftClosed:
			Springy["Location"] = 16
			print("Springy is in Position")
		else:
			Springy["Location"] = 0
			print("Springy moves to Cam 1")
