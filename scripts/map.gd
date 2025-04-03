extends AnimatedSprite2D

@onready var CamBG = $"../CamBG"
@onready var CamNum = $CamNumBox/CamNum
@onready var Distort = $"../CamDistort"
@onready var SFX = $"../../../SFX"

func _on_cam_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 0:
			Global.CameraView = 0
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 1:
			Global.CameraView = 1
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 2:
			Global.CameraView = 2
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 3:
			Global.CameraView = 3
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_5_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 4:	
			Global.CameraView = 4
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_6_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 5:
			Global.CameraView = 5
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_7_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 6:
			Global.CameraView = 6
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_8_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 7:
			Global.CameraView = 7
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_9_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 8:
			Global.CameraView = 8
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_10_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 9:
			Global.CameraView = 9
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_11_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 10:
			Global.CameraView = 10
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_12_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 11:
			Global.CameraView = 11
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_13_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 12:
			Global.CameraView = 12
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func _on_cam_14_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !Global.CameraView == 13:
			Global.CameraView = 13
			SFX.stream = preload("res://assets/audio/CamsChange.wav")
			SFX.play()

func DistortCamera() -> void:
	SFX.stream = preload("res://assets/audio/CamsDistort.wav")
	SFX.play()
	Distort.visible = true
	await get_tree().process_frame
	Distort.flip_h = 1
	await get_tree().process_frame
	Distort.flip_h = 0
	await get_tree().process_frame
	Distort.flip_h = 1
	await get_tree().process_frame
	Distort.flip_h = 0
	await get_tree().process_frame
	Distort.flip_h = 1
	await get_tree().process_frame
	Distort.flip_h = 0
	await get_tree().process_frame
	Distort.visible = false

func MoveEnemies() -> void:
	for enemy in EnemyAI.enemies:
		if enemy["LastLocation"] != enemy["Location"]:
			if enemy["LastLocation"] in [15, 16, 17] and enemy["Location"] == enemy["Start"]:
				SFX.stream = preload("res://assets/audio/Thunk.wav")
				SFX.play()
			if Global.CamerasUp:
				if Global.CameraView == enemy["LastLocation"]:
					DistortCamera()
				elif Global.CameraView == enemy["Location"]:
					DistortCamera()
			if enemy["Location"] == 9:
				SFX.stream = preload("res://assets/audio/VentEnter.wav")
				SFX.play()
			enemy["LastLocation"] = enemy["Location"]

func ClearCamSprites() -> void:
	var nodes = get_children()
	for node in nodes:
		if node is Sprite2D:
			node.queue_free()

func _process(delta: float) -> void:
	MoveEnemies()
	ClearCamSprites()
	if Global.CameraView == 0:
		set_frame(0)
		CamBG.set_frame(0)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 0:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam1.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 1:
		set_frame(1)
		CamBG.set_frame(1)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 1:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam2.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 2:
		set_frame(2)
		CamBG.set_frame(2)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 2:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam3.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 3:
		set_frame(3)
		CamBG.set_frame(3)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 3:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam4.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 4:
		set_frame(4)
		CamBG.set_frame(4)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 4:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam5.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 5:
		set_frame(5)
		CamBG.set_frame(5)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 5:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam6.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 6:
		set_frame(6)
		CamBG.set_frame(6)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 6:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam7.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 7:
		set_frame(7)
		CamBG.set_frame(7)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 7:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam8.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 8:
		set_frame(8)
		CamBG.set_frame(8)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 8:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam9.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 9:
		set_frame(9)
		CamBG.set_frame(9)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 9:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam10.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 10:
		set_frame(10)
		CamBG.set_frame(10)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 10:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam11.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 11:
		set_frame(11)
		CamBG.set_frame(11)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 11:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam12.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 12:
		set_frame(12)
		CamBG.set_frame(12)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 12:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam13.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	elif Global.CameraView == 13:
		set_frame(13)
		CamBG.set_frame(13)
		for enemy in EnemyAI.enemies:
			if enemy["Location"] == 13:
				var new_enemy = Sprite2D.new()
				var path = "res://assets/" + enemy["Name"] + "Cam14.png"
				new_enemy.texture = load(path)
				new_enemy.show_behind_parent = true
				add_child(new_enemy)
	CamNum.text = "Cam " + str(Global.CameraView + 1)
