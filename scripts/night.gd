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
@onready var SFX = $GUI/SFX
@onready var Blackout = $GUI/Blackout

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

var JumpscareYMin = 200
var JumpscareShake = 10

func _ready() -> void:
	EnemyAI.InitializeEnemies()

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
			SFX.stream = preload("res://assets/audio/DoorClose.wav")
			SFX.play()
			DoorLeft.position.y -= 11
			while DoorLeft.position.y != DoorYMin:
				DoorLeft.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.DoorRightClosed:
			Global.DoorRightClosed = false
			SFX.stream = preload("res://assets/audio/DoorClose.wav")
			SFX.play()
			DoorRight.position.y -= 11.25
			while DoorRight.position.y != DoorYMin:
				DoorRight.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.VentClosed:
			Global.VentClosed = false
			SFX.stream = preload("res://assets/audio/VentClose.wav")
			SFX.play()
			while Vent.position.y != VentYMax:
				Vent.position.y += VentSpeed
				await get_tree().process_frame
		if Global.CamerasUp:
			Global.CamerasUp = false
			SFX.stream = preload("res://assets/audio/CamsClose.wav")
			SFX.play()
			while Cameras.position.y != CameraPositionYMax:
				Cameras.position.y += CameraSpeed
				await get_tree().process_frame
		Power.text = "0%"
		if !Blackout.visible:
			Blackout.visible = true
			SFX.stream = preload("res://assets/audio/Blackout.wav")
			SFX.play()
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
	#Enemy AI Move
	EnemyAI.MoveCheck()
	#Remove Enemies
	var nodes = $Enemies.get_children()
	for node in nodes:
		node.queue_free()
	#Draw Enemies
	for enemy in EnemyAI.enemies:
		if enemy["Location"] == 15:
			var new_enemy = Sprite2D.new()
			var path = "res://assets/" + enemy["Name"] + "Office.png"
			new_enemy.texture = load(path)
			$Enemies.add_child(new_enemy)
		if enemy["Location"] == 16:
			var new_enemy = Sprite2D.new()
			var path = "res://assets/" + enemy["Name"] + "JS.png"
			new_enemy.texture = load(path)
			$GUI/Jumpscare.add_child(new_enemy)
			timer.stop()
			Jumpscare.offset.y = JumpscareYMin
			SFX.stream = preload("res://assets/audio/Jumpscare.wav")
			SFX.play()
			while Jumpscare.offset.y > (JumpscareYMin - 40):
				Jumpscare.offset.y -= JumpscareShake
				await get_tree().process_frame
			while Jumpscare.offset.y < (JumpscareYMin + 40):
				Jumpscare.offset.y += JumpscareShake
				await get_tree().process_frame
			while Jumpscare.offset.y > (JumpscareYMin - 40):
				Jumpscare.offset.y -= JumpscareShake
				await get_tree().process_frame
			while Jumpscare.offset.y < (JumpscareYMin + 40):
				Jumpscare.offset.y += JumpscareShake
				await get_tree().process_frame
			get_tree().quit()

func _process(_delta: float) -> void:	
	#handle input
	if Global.HasPower:
		if Input.is_action_just_pressed("LeftDoor"):
			if !Global.DoorLeftClosed:
				Global.DoorLeftClosed = true
				SFX.stream = preload("res://assets/audio/DoorOpen.wav")
				SFX.play()
				DoorLeft.position.y += 11
				while DoorLeft.position.y != DoorLeftYMax:
					DoorLeft.position.y += DoorSpeed
					await get_tree().process_frame
			else:
				Global.DoorLeftClosed = false
				SFX.stream = preload("res://assets/audio/DoorClose.wav")
				SFX.play()
				DoorLeft.position.y -= 11
				while DoorLeft.position.y != DoorYMin:
					DoorLeft.position.y -= DoorSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("RightDoor"):
			if !Global.DoorRightClosed:
				Global.DoorRightClosed = true
				SFX.stream = preload("res://assets/audio/DoorOpen.wav")
				SFX.play()
				DoorRight.position.y += 11.25
				while DoorRight.position.y != DoorRightYMax:
					DoorRight.position.y += DoorSpeed
					await get_tree().process_frame
			else:
				Global.DoorRightClosed = false
				SFX.stream = preload("res://assets/audio/DoorClose.wav")
				SFX.play()
				DoorRight.position.y -= 11.25
				while DoorRight.position.y != DoorYMin:
					DoorRight.position.y -= DoorSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("Vent"):
			if !Global.VentClosed:
				Global.VentClosed = true
				SFX.stream = preload("res://assets/audio/VentOpen.wav")
				SFX.play()
				while Vent.position.y != VentYMin:
					Vent.position.y -= VentSpeed
					await get_tree().process_frame
			else:
				Global.VentClosed = false
				SFX.stream = preload("res://assets/audio/VentClose.wav")
				SFX.play()
				while Vent.position.y != VentYMax:
					Vent.position.y += VentSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("Cameras"):
			if !Global.CamerasUp:
				Global.CamerasUp = true
				SFX.stream = preload("res://assets/audio/CamsOpen.wav")
				SFX.play()
				while Cameras.position.y != CameraPositionYMin:
					Cameras.position.y -= CameraSpeed
					await get_tree().process_frame
			else:
				Global.CamerasUp = false
				SFX.stream = preload("res://assets/audio/CamsClose.wav")
				SFX.play()
				while Cameras.position.y != CameraPositionYMax:
					Cameras.position.y += CameraSpeed
					await get_tree().process_frame
