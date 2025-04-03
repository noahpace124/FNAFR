extends Node

var CameraPositionYMin = 200
var CameraPositionYMax = 600
var CameraSpeed = 40

var JumpscareMinY = 200
var JumpscareShake = 20

var rng = RandomNumberGenerator.new()

var Springy = {
	"Name": "Springy",
	"Start": 0,
	"LastLocation": -1,
	"Location": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 4.9
}

var Lovely = {
	"Name": "Lovely",
	"Start": 0,
	"LastLocation": -1,
	"Location": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 4.6
}

var enemies = []

func InitializeEnemies() -> void:
	for enemy in enemies:
		enemy["Location"] = enemy["Start"]
		enemy["LastLocation"] = enemy["Location"]

func MoveCheck() -> void:
	for enemy in enemies:
		enemy["Wait"] += 0.1
		if enemy["Wait"] >= enemy["Act"]:
			print(enemy["Name"] + " gets Impatient")
			var num = rng.randi_range(1, 20)
			if num <= enemy["AI"]:
				if enemy["Name"] == "Springy":
					SpringyMove()
				elif enemy["Name"] == "Lovely":
					LovelyMove()
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
				print("Springy moves to the Left Door")
	elif Springy["Location"] == 15:
		if !Global.DoorLeftClosed:
			Springy["Location"] = 18
			print("Springy is in Position")
		else:
			Springy["Location"] = 0
			print("Springy moves to Cam 1")

func LovelyMove() -> void:
	var Lovely = GetEnemyByName("Lovely")
	if Lovely["Location"] == 0: #
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 1
			print("Lovely moves to Cam 2")
		else:
			Lovely["Location"] = 5
			print("Lovely moves to Cam 6")
	elif Lovely["Location"] == 1:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 4
			print("Lovely moves to Cam 5")
		else:
			Lovely["Location"] = 5
			print("Lovely moves to Cam 6")
	elif Lovely["Location"] == 4:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 6
			print("Lovely moves to Cam 7")
		else:
			Lovely["Location"] = 11
			print("Lovely moves to Cam 12")
	elif Lovely["Location"] == 5:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 4
			print("Lovely moves to Cam 5")
		else:
			Lovely["Location"] = 6
			print("Lovely moves to Cam 7")
	elif Lovely["Location"] == 6:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 10
			print("Lovely moves to Cam 11")
		else:
			Lovely["Location"] = 11
			print("Lovely moves to Cam 12")
	elif Lovely["Location"] == 10:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 9
			print("Lovely moves to Cam 10")
		else:
			Lovely["Location"] = 13
			print("Lovely moves to Cam 14")
	elif Lovely["Location"] == 9:
		if Global.CamerasUp:
			Lovely["Location"] = 16
			print("Lovely moves to the Vent")
	elif Lovely["Location"] == 11:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 10
			print("Lovely moves to Cam 11")
		else:
			Lovely["Location"] = 13
			print("Lovely moves to Cam 14")
	elif Lovely["Location"] == 13:
		var change = rng.randf()
		if change < 0.5: #50/50
			Lovely["Location"] = 10
			print("Lovely moves to Cam 11")
		else:
			if Global.CamerasUp or Global.LookingLeft:
				Lovely["Location"] = 17
				print("Lovely moves to the Right Door")
	elif Lovely["Location"] == 16:
		if !Global.VentClosed:
			Lovely["Location"] = 18
			print("Lovely is in Position")
		else:
			Lovely["Location"] = 0
			print("Lovely moves to Cam 1")
	elif Lovely["Location"] == 17:
		if !Global.DoorRightClosed:
			Lovely["Location"] = 18
			print("Lovely is in Position")
		else:
			Lovely["Location"] = 0
			print("Lovely moves to Cam 1")
	
	
		
		
