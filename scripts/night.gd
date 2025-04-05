extends Node

@onready var DoorLeft = $DoorLeft
@onready var DoorRight = $DoorRight
@onready var Vent = $Vent
@onready var Cameras = $GUI/Cameras/CamerasBackground
@onready var camera = $GUI
@onready var AM = $AM
@onready var time= $GUI/Time
@onready var timer = $Timer
@onready var Power = $GUI/Power
@onready var Jumpscare = $GUI/Jumpscare
@onready var OfficeSFX = $GUI/OfficeSFX
@onready var EnemySFX = $GUI/EnemySFX
@onready var Blackout = $GUI/Blackout
@onready var Office = $Office

var DoorLeftYMax = 311
var DoorRightYMax = 311.25
var DoorYMin = 0
var DoorSpeed = 50

var VentYMax = 411.25
var VentYMin = 311.25
var VentSpeed = 25

var CameraPositionYMin = 200
var CameraPositionYMax = 600
var CameraSpeed = 40

var JumpscareYMin = -400
var JumpscareSpeed = 100
var JumpscareReady = false

var GigglesSFX = false

var rng = RandomNumberGenerator.new()

var WindowSpeed = 50

var packed_scene = PackedScene

func _ready() -> void:
	#DEBUG
	#Default States
	EnemyAI.InitializeEnemies()
	Global.CurrentPower = Global.StartingPower
	Global.DoorLeftClosed = false
	Global.DoorRightClosed = false
	Global.VentClosed = false
	Global.CamerasUp = false
	Global.HasPower = true
	Global.DoorRightWorks = true
	Global.DoorLeftWorks = true
	Global.VentWorks = true
	Global.CameraCanPan = true
	Blackout.visible = false
	EnemyAI.Jumpscaring = false
	Global.next_scene = "res://scenes/win.tscn"
	# Start loading the next scene
	ResourceLoader.load_threaded_request(Global.next_scene)

	# Wait until the scene is loaded
	while ResourceLoader.load_threaded_get_status(Global.next_scene) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame  # Yield until the scene is loaded

	# Get the loaded PackedScene
	packed_scene = ResourceLoader.load_threaded_get(Global.next_scene)

func _on_timer_timeout() -> void:
	time.text = str(float(time.text) + 0.1)
	#Idle Power
	Global.CurrentPower -= Global.IdlePowerDrain
	#Camera Power
	if Global.CamerasUp:
		Global.CurrentPower -= Global.CameraPowerDrain
	#Door Power
	if Global.DoorLeftClosed:
		Global.CurrentPower -= Global.DoorPowerDrain
	if Global.DoorRightClosed:
		Global.CurrentPower -= Global.DoorPowerDrain
	#Vent Power
	if Global.VentClosed:
		Global.CurrentPower -= Global.VentPowerDrain
	#Check for No Power
	if Global.CurrentPower <= 0:
		Global.HasPower = false
		if Global.DoorLeftClosed:
			Global.DoorLeftClosed = false
			OfficeSFX.stream = preload("res://assets/audio/DoorClose.wav")
			OfficeSFX.play()
			DoorLeft.position.y -= 11
			while DoorLeft.position.y != DoorYMin:
				DoorLeft.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.DoorRightClosed:
			Global.DoorRightClosed = false
			OfficeSFX.stream = preload("res://assets/audio/DoorClose.wav")
			OfficeSFX.play()
			DoorRight.position.y -= 11.25
			while DoorRight.position.y != DoorYMin:
				DoorRight.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.VentClosed:
			Global.VentClosed = false
			OfficeSFX.stream = preload("res://assets/audio/VentClose.wav")
			OfficeSFX.play()
			while Vent.position.y != VentYMax:
				Vent.position.y += VentSpeed
				await get_tree().process_frame
		if Global.CamerasUp:
			Global.CamerasUp = false
			Global.CamerasJustDown = true
			OfficeSFX.stream = preload("res://assets/audio/CamsClose.wav")
			OfficeSFX.play()
			while Cameras.position.y != CameraPositionYMax:
				Cameras.position.y += CameraSpeed
				await get_tree().process_frame
			Global.CamerasJustDown = false
		Power.text = "0%"
		if !Blackout.visible:
			Blackout.visible = true
			OfficeSFX.stream = preload("res://assets/audio/Blackout.wav")
			OfficeSFX.play()
	else:
		Power.text = str(int(Global.CurrentPower)) + "%"
	#Update Time
	if float(time.text) == 20.0:
		AM.text = "1:00 AM"
	elif float(time.text) == 40.0:
		AM.text = "2:00 AM"
	elif float(time.text) == 60.0:
		AM.text = "3:00 AM"
	elif float(time.text) == 80.0:
		AM.text = "4:00 AM"
	elif float(time.text) == 100.0:
		AM.text = "5:00 AM"
	elif float(time.text) == 120.0:
		AM.text = "6:00 AM"
		get_tree().change_scene_to_packed(packed_scene)
		Global.next_scene = "res://scenes/title.tscn"
		return
	#Enemy AI Move
	EnemyAI.MoveCheck()

func HandleEnemies():
	if !EnemyAI.Jumpscaring: #Not in the middle of a jumpscare
		#Remove Enemies
		var nodes = $EnemiesLeftDoor.get_children()
		for node in nodes:
			node.queue_free()
		nodes = $EnemiesVent.get_children()
		for node in nodes:
			node.queue_free()
		nodes = $EnemiesRightDoor.get_children()
		for node in nodes:
			node.queue_free()
		nodes = $EnemiesWindow.get_children()
		for node in nodes:
			node.queue_free()
		#Draw Enemies
		#Giggly
		if EnemyAI.Giggly["Attack"] and !EnemyAI.Giggly["Attacking"]:
			EnemyAI.Giggly["Attack"] = false
			EnemyAI.Giggly["Attacking"] = true
			var previous_location = EnemyAI.Giggly["Location"]
			EnemyAI.Giggly["Location"] = -1
			EnemySFX.stream = preload("res://assets/audio/GigglyAlert.wav")
			EnemySFX.play()
			await get_tree().create_timer(4.0).timeout
			if EnemyAI.Giggly["Side"] == "Left":
				if !Global.DoorLeftClosed:
					EnemyAI.Giggly["Location"] = 18
				elif Global.DoorLeftClosed and Global.DoorRightClosed:
					Global.CurrentPower -= 5
					EnemySFX.stream = preload("res://assets/audio/Thunk.wav")
					EnemySFX.play()
					EnemyAI.Giggly["Attacking"] = false
					EnemyAI.Giggly["Location"] = previous_location
				else:
					EnemySFX.stream = preload("res://assets/audio/Thunk.wav")
					EnemySFX.play()
					EnemyAI.Giggly["Attacking"] = false
					EnemyAI.Giggly["Location"] = previous_location
			elif EnemyAI.Giggly["Side"] == "Right":
				if !Global.DoorRightClosed:
					EnemyAI.Giggly["Location"] = 18
				elif Global.DoorLeftClosed and Global.DoorRightClosed:
					Global.CurrentPower -= 5
					EnemySFX.stream = preload("res://assets/audio/Thunk.wav")
					EnemySFX.play()
					EnemyAI.Giggly["Attacking"] = false
					EnemyAI.Giggly["Location"] = previous_location
				else:
					EnemySFX.stream = preload("res://assets/audio/Thunk.wav")
					EnemySFX.play()
					EnemyAI.Giggly["Attacking"] = false
					EnemyAI.Giggly["Location"] = previous_location
		elif EnemyAI.Giggly["Move"] and !EnemyAI.Giggly["Attacking"]:
			var giggly = Sprite2D.new()
			var giggly_path = ""
			if EnemyAI.Giggly["Tilt"] == false:
				giggly_path = "res://assets/GigglyOffice.png"
			else:
				giggly_path = "res://assets/GigglyOfficeTilt.png"
			if EnemyAI.Giggly["Side"] == "Right":
				giggly.flip_h = true
			if EnemyAI.Giggly["TiltWait"] == 0: 
				EnemyAI.Giggly["Tilt"] = !EnemyAI.Giggly["Tilt"]
				EnemyAI.Giggly["TiltWait"] = 20
			else:
				EnemyAI.Giggly["TiltWait"] -= 1
			giggly.texture = load(giggly_path)
			giggly.position.y = EnemyAI.Giggly["Y"]
			giggly.position.x = EnemyAI.Giggly["X"]
			$EnemiesWindow.add_child(giggly)
			if !GigglesSFX:
				EnemySFX.stream = preload("res://assets/audio/GigglyRun.wav")
				EnemySFX.play()
				GigglesSFX = true
			if EnemyAI.Giggly["Side"] == "Right":
				if EnemyAI.Giggly["X"] != EnemyAI.Giggly["MaxX"]:
					giggly.position.x += EnemyAI.Giggly["Speed"]
					EnemyAI.Giggly["X"] += EnemyAI.Giggly["Speed"]
					await get_tree().process_frame
			elif EnemyAI.Giggly["Side"] == "Left":
				if EnemyAI.Giggly["X"] != EnemyAI.Giggly["MinX"]:
					giggly.position.x -= EnemyAI.Giggly["Speed"]
					EnemyAI.Giggly["X"] -= EnemyAI.Giggly["Speed"]
					await get_tree().process_frame
			if EnemyAI.Giggly["Side"] == "Right" and EnemyAI.Giggly["X"] == EnemyAI.Giggly["MaxX"]:
				EnemyAI.Giggly["Move"] = false
				GigglesSFX = false
				EnemyAI.Giggly["Location"] = 13
			elif EnemyAI.Giggly["Side"] == "Left" and EnemyAI.Giggly["X"] == EnemyAI.Giggly["MinX"]:
				EnemyAI.Giggly["Move"] = false
				GigglesSFX = false
				EnemyAI.Giggly["Location"] = 12
		#Others
		for enemy in EnemyAI.enemies:
			if enemy["Location"] in [15, 16, 17]:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + str(enemy["Location"]) + ".png"
				new_enemy.texture = load(path)
				if enemy["Location"] == 15:
					$EnemiesLeftDoor.add_child(new_enemy)
				elif enemy["Location"] == 16:
					$EnemiesVent.add_child(new_enemy)
				else:
					$EnemiesRightDoor.add_child(new_enemy)
			if enemy["Location"] == 18:
				if !JumpscareReady:
					var JumpscareWait = rng.randf_range(6.0, 10.0)
					await get_tree().create_timer(JumpscareWait).timeout
					JumpscareReady = true
				elif Global.CamerasUp:
					Global.CamerasUp = false
					Global.CamerasJustDown = true
					OfficeSFX.stream = preload("res://assets/audio/CamsClose.wav")
					OfficeSFX.play()
					while Cameras.position.y != CameraPositionYMax:
						Cameras.position.y += CameraSpeed
						await get_tree().process_frame
					Global.CamerasJustDown = true
				else:
					Global.CameraCanPan = false
					EnemyAI.Jumpscaring = true
					var new_enemy = Sprite2D.new()
					var path = "res://assets/" + enemy["Name"] + "JS.png"
					new_enemy.texture = load(path)
					new_enemy.offset.y = Jumpscare.offset.y
					Jumpscare.add_child(new_enemy)
					timer.stop()
					EnemySFX.stream = preload("res://assets/audio/Jumpscare.wav")
					EnemySFX.play()
					while new_enemy.offset.y != JumpscareYMin:
						new_enemy.offset.y -= JumpscareSpeed
						await get_tree().process_frame
					await get_tree().create_timer(0.75).timeout
					#ReActivate Giggles
					EnemyAI.Giggly["Attacking"] = false
					# Start loading the scene
					Global.next_scene = "res://scenes/title.tscn"
					ResourceLoader.load_threaded_request(Global.next_scene)
					# Wait until the scene is loaded
					while ResourceLoader.load_threaded_get_status(Global.next_scene) != ResourceLoader.THREAD_LOAD_LOADED:
						await get_tree().process_frame  # Yield until the scene is loaded
					# Get the loaded PackedScene
					packed_scene = ResourceLoader.load_threaded_get(Global.next_scene)
					get_tree().change_scene_to_packed(packed_scene)

func _process(_delta: float) -> void:
	#Enemies
	HandleEnemies()
	#handle input
	if Global.HasPower:
		if Input.is_action_just_pressed("LeftDoor"):
			if Global.DoorLeftWorks:
				if !Global.DoorLeftClosed:
					Global.DoorLeftClosed = true
					OfficeSFX.stream = preload("res://assets/audio/DoorOpen.wav")
					OfficeSFX.play()
					DoorLeft.position.y += 11
					while DoorLeft.position.y != DoorLeftYMax:
						DoorLeft.position.y += DoorSpeed
						await get_tree().process_frame
				else:
					Global.DoorLeftClosed = false
					OfficeSFX.stream = preload("res://assets/audio/DoorClose.wav")
					OfficeSFX.play()
					DoorLeft.position.y -= 11
					while DoorLeft.position.y != DoorYMin:
						DoorLeft.position.y -= DoorSpeed
						await get_tree().process_frame
			else:
				OfficeSFX.stream = preload("res://assets/audio/Disabled.wav")
				OfficeSFX.play()
		if Input.is_action_just_pressed("RightDoor"):
			if Global.DoorRightWorks:
				if !Global.DoorRightClosed:
					Global.DoorRightClosed = true
					OfficeSFX.stream = preload("res://assets/audio/DoorOpen.wav")
					OfficeSFX.play()
					DoorRight.position.y += 11.25
					while DoorRight.position.y != DoorRightYMax:
						DoorRight.position.y += DoorSpeed
						await get_tree().process_frame
				else:
					Global.DoorRightClosed = false
					OfficeSFX.stream = preload("res://assets/audio/DoorClose.wav")
					OfficeSFX.play()
					DoorRight.position.y -= 11.25
					while DoorRight.position.y != DoorYMin:
						DoorRight.position.y -= DoorSpeed
						await get_tree().process_frame
			else:
				OfficeSFX.stream = preload("res://assets/audio/Disabled.wav")
				OfficeSFX.play()
		if Input.is_action_just_pressed("Vent"):
			if Global.VentWorks:
				if !Global.VentClosed:
					Global.VentClosed = true
					OfficeSFX.stream = preload("res://assets/audio/VentOpen.wav")
					OfficeSFX.play()
					while Vent.position.y != VentYMin:
						Vent.position.y -= VentSpeed
						await get_tree().process_frame
				else:
					Global.VentClosed = false
					OfficeSFX.stream = preload("res://assets/audio/VentClose.wav")
					OfficeSFX.play()
					while Vent.position.y != VentYMax:
						Vent.position.y += VentSpeed
						await get_tree().process_frame
			else:
				OfficeSFX.stream = preload("res://assets/audio/Disabled.wav")
				OfficeSFX.play()
		if Input.is_action_just_pressed("Cameras"):
			if !Global.CamerasUp:
				Global.CamerasUp = true
				OfficeSFX.stream = preload("res://assets/audio/CamsOpen.wav")
				OfficeSFX.play()
				while Cameras.position.y != CameraPositionYMin:
					Cameras.position.y -= CameraSpeed
					await get_tree().process_frame
			else:
				Global.CamerasUp = false
				Global.CamerasJustDown = true
				OfficeSFX.stream = preload("res://assets/audio/CamsClose.wav")
				OfficeSFX.play()
				while Cameras.position.y != CameraPositionYMax:
					Cameras.position.y += CameraSpeed
					await get_tree().process_frame
				Global.CamerasJustDown = false
