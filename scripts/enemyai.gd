extends Node

var CameraPositionYMin = 200
var CameraPositionYMax = 600
var CameraSpeed = 40

var JumpscareMinY = 200
var JumpscareShake = 20
var Jumpscaring = false

var rng = RandomNumberGenerator.new()

var Springy = {
	"Name": "Springy",
	"Start": 0,
	"LastLocation": -1,
	"Location": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 4.6
}

var Lovely = {
	"Name": "Lovely",
	"Start": 0,
	"LastLocation": -1,
	"Location": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 4.9
}

var Sneaky = {
	"Name": "Sneaky",
	"Start": 5,
	"LastLocation": -1,
	"Location": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 5.2
}

var Giggly = {
	"Name": "Giggly",
	"Start": 12,
	"Location": -1,
	"LastLocation": -1,
	"AI": 0,
	"Wait": 0.0,
	"Act": 6.0,
	"Attack": false,
	"Attacking": false,
	"Side": "Left",
	"Move": false,
	"X": 100,
	"Y": 250,
	"MinX": 100,
	"MaxX": 800,
	"Speed": 5,
	"Tilt": false,
	"TiltWait": 20
}

var enemies = []

func InitializeEnemies() -> void:
	for enemy in enemies:
		if enemy["Start"] != -1:
			enemy["Location"] = enemy["Start"]
			enemy["LastLocation"] = enemy["Location"]

func MoveCheck() -> void:
	for enemy in enemies:
		if enemy["Name"] in ["Sneaky", "Giggly"]:
			if enemy["Name"] == "Sneaky":
				SneakyMove()
			if enemy["Name"] == "Giggly":
				GigglyMove()
		else:
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
			if !Global.LookingLeft:
				Springy["Location"] = 18
				Global.DoorLeftWorks = false
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
			if Global.CamerasUp or !Global.LookingRight:
				Lovely["Location"] = 17
				print("Lovely moves to the Right Door")
	elif Lovely["Location"] == 16:
		if !Global.VentClosed:
			if Global.CamerasUp:
				Lovely["Location"] = 18
				Global.VentWorks = false
				print("Lovely is in Position")
		else:
			Lovely["Location"] = 0
			print("Lovely moves to Cam 1")
	elif Lovely["Location"] == 17:
		if !Global.DoorRightClosed:
			if !Global.LookingRight:
				Lovely["Location"] = 18
				Global.DoorRightWorks = false
				print("Lovely is in Position")
		else:
			Lovely["Location"] = 0
			print("Lovely moves to Cam 1")
	
func SneakyMove():
	var Sneaky = GetEnemyByName("Sneaky")
	Sneaky["Wait"] += 0.1
	if Sneaky["Wait"] >= Sneaky["Act"]:
		print(Sneaky["Name"] + " gets Impatient")
		if Sneaky["Location"] == 5:
			if !Global.CameraView == 5 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					var change = rng.randf()
					if change < 0.5: #50/50
						Sneaky["Location"] = 2
						print("Sneaky moves to Cam 3")
					else:
						Sneaky["Location"] = 1
						print("Sneaky moves to Cam 2")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 2:
			if !Global.CameraView == 2 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 3
					print("Sneaky moves to Cam 4")
			else:
				Sneaky["Location"] = 5
				print("Sneaky goes back to Cam 6")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 3:
			if !Global.CameraView == 3 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 8
					print("Sneaky moves to Cam 9")
			else:
				Sneaky["Location"] = 2
				print("Sneaky goes back to Cam 3")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 8:
			if !Global.CameraView == 8 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 12
					print("Sneaky moves to Cam 13 and is at Left Door")
			else:
				Sneaky["Location"] = 3
				print("Sneaky goes back to Cam 4")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 12:
			if !Global.CameraView == 12 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					if !Global.DoorLeftClosed:
						Sneaky["Location"] = 18
						print("Sneaky is in Position")
			else:
				Sneaky["Location"] = 8
				print("Sneaky goes back to Cam 9")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 1:
			if !Global.CameraView == 1 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 4
					print("Sneaky moves to Cam 5")
			else:
				Sneaky["Location"] = 5
				print("Sneaky goes back to Cam 6")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 4:
			if !Global.CameraView == 4 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 11
					print("Sneaky moves to Cam 12")
			else:
				Sneaky["Location"] = 1
				print("Sneaky goes back to Cam 2")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 11:
			if !Global.CameraView == 11 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					Sneaky["Location"] = 13
					print("Sneaky moves to Cam 14 and is at Right Door")
			else:
				Sneaky["Location"] = 4
				print("Sneaky goes back to Cam 5")
			Sneaky["Wait"] = 0.0
		elif Sneaky["Location"] == 13:
			if !Global.CameraView == 13 or !Global.CamerasUp:
				var num = rng.randi_range(1, 20)
				if num <= Sneaky["AI"]:
					if !Global.DoorRightClosed:
						Sneaky["Location"] = 18
						print("Sneaky is in Position")
			else:
				Sneaky["Location"] = 11
				print("Sneaky goes back to Cam 12")
			Sneaky["Wait"] = 0.0
				
func GigglyMove():
	var Giggly = GetEnemyByName("Giggly")
	Giggly["Wait"] += 0.1
	if Giggly["Wait"] >= Giggly["Act"]:
		if !Giggly["Move"] and !Giggly["Attacking"]:
			print("Giggly gets Impatient")
			var num = rng.randi_range(1, 20)
			if num <= Giggly["AI"]:
				num = rng.randi_range(1, 5) #1/5
				if num == 1:
					print("Giggly Attacks")
					Giggly["Attack"] = true
					await get_tree().create_timer(2.0).timeout
				else:
					if Giggly["Side"] == "Right":
						print("Giggly moves to Left Door")
						Giggly["Side"] = "Left"
						Giggly["Location"] = -1
						Giggly["Move"] = true
					else:
						print("Giggly moves to Right Door")
						Giggly["Side"] = "Right"
						Giggly["Location"] = -1
						Giggly["Move"] = true
		Giggly["Wait"] = 0.0
	
