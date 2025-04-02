extends Node

@onready var DoorLeft = $DoorLeft
@onready var DoorRight = $DoorRight
@onready var Vent = $Vent
@onready var Cameras = $GUI/Cameras/CamerasBackground
@onready var camera = $GUI
@onready var AM = $GUI/AM
@onready var time= $GUI/Time
@onready var timer = $Timer
@onready var Power = $GUI/Power
@onready var Jumpscare = $GUI/Jumpscare

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
			DoorLeft.position.y -= 11
			while DoorLeft.position.y != DoorYMin:
				DoorLeft.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.DoorRightClosed:
			Global.DoorRightClosed = false
			DoorRight.position.y -= 11.25
			while DoorRight.position.y != DoorYMin:
				DoorRight.position.y -= DoorSpeed
				await get_tree().process_frame
		if Global.VentClosed:
			Global.VentClosed = false
			while Vent.position.y != VentYMax:
				Vent.position.y += VentSpeed
				await get_tree().process_frame
		if Global.CamerasUp:
			Global.CamerasUp = false
			while Cameras.position.y != CameraPositionYMax:
				Cameras.position.y += CameraSpeed
				await get_tree().process_frame
		Power.text = "0%"
	else:
		Power.text = str(int(Global.CurrentPower)) + "%"
	#Update Time
	if float(time.text) == 20.0:
		AM.text = "1 AM"
	elif float(time.text) == 40.0:
		AM.text = "2 AM"
	elif float(time.text) == 60.0:
		AM.text = "3 AM"
	elif float(time.text) == 80.0:
		AM.text = "4 AM"
	elif float(time.text) == 100.0:
		AM.text = "5 AM"
	elif float(time.text) == 120.0:
		AM.text = "OVERTIME"
	#Enemy AI
	EnemyAI.SpringyMoveCheck()
	#Remove Enemies
	var nodes = $Enemies.get_children()
	for node in nodes:
		node.queue_free()
	#Draw Enemies
	if EnemyAI.SpringyLocation == 15:
		var Springy = Sprite2D.new()
		Springy.texture = preload("res://assets/SpringyOffice.png")
		$Enemies.add_child(Springy)
	if EnemyAI.SpringyLocation == 16:
		var Springy = Sprite2D.new()
		Springy.texture = preload("res://assets/SpringyJS.png")
		$GUI/Jumpscare.add_child(Springy)
		timer.stop()
		Jumpscare.offset.y = JumpscareYMin
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
				DoorLeft.position.y += 11
				while DoorLeft.position.y != DoorLeftYMax:
					DoorLeft.position.y += DoorSpeed
					await get_tree().process_frame
			else:
				Global.DoorLeftClosed = false
				DoorLeft.position.y -= 11
				while DoorLeft.position.y != DoorYMin:
					DoorLeft.position.y -= DoorSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("RightDoor"):
			if !Global.DoorRightClosed:
				Global.DoorRightClosed = true
				DoorRight.position.y += 11.25
				while DoorRight.position.y != DoorRightYMax:
					DoorRight.position.y += DoorSpeed
					await get_tree().process_frame
			else:
				Global.DoorRightClosed = false
				DoorRight.position.y -= 11.25
				while DoorRight.position.y != DoorYMin:
					DoorRight.position.y -= DoorSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("Vent"):
			if !Global.VentClosed:
				Global.VentClosed = true
				while Vent.position.y != VentYMin:
					Vent.position.y -= VentSpeed
					await get_tree().process_frame
			else:
				Global.VentClosed = false
				while Vent.position.y != VentYMax:
					Vent.position.y += VentSpeed
					await get_tree().process_frame
		if Input.is_action_just_pressed("Cameras"):
			if !Global.CamerasUp:
				Global.CamerasUp = true
				while Cameras.position.y != CameraPositionYMin:
					Cameras.position.y -= CameraSpeed
					await get_tree().process_frame
			else:
				Global.CamerasUp = false
				while Cameras.position.y != CameraPositionYMax:
					Cameras.position.y += CameraSpeed
					await get_tree().process_frame
