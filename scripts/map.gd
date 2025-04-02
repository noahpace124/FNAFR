extends AnimatedSprite2D

@onready var CamBG = $CamBG
@onready var CamNum = $CamNum

func _on_cam_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 0

func _on_cam_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 1

func _on_cam_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 2

func _on_cam_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 3

func _on_cam_5_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 4

func _on_cam_6_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 5

func _on_cam_7_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 6

func _on_cam_8_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 7

func _on_cam_9_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 8

func _on_cam_10_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 9

func _on_cam_11_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 10

func _on_cam_12_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 11

func _on_cam_13_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 12

func _on_cam_14_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.CameraView = 13

func ClearSprites() -> void:
	var nodes = get_children()
	for node in nodes:
		if node is Sprite2D:
			if node != CamBG:
				node.queue_free()

func _process(delta: float) -> void:
	ClearSprites()
	if Global.CameraView == 0:
		set_frame(0)
		CamBG.set_frame(0)
		if EnemyAI.SpringyLocation == 0:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam1.png")
			add_child(SpringyCam)
	elif Global.CameraView == 1:
		set_frame(1)
		CamBG.set_frame(1)
	elif Global.CameraView == 2:
		set_frame(2)
		CamBG.set_frame(2)
		if EnemyAI.SpringyLocation == 2:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam3.png")
			add_child(SpringyCam)
	elif Global.CameraView == 3:
		set_frame(3)
		CamBG.set_frame(3)
	elif Global.CameraView == 4:
		set_frame(4)
		CamBG.set_frame(4)
	elif Global.CameraView == 5:
		set_frame(5)
		CamBG.set_frame(5)
		if EnemyAI.SpringyLocation == 5:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam6.png")
			add_child(SpringyCam)
	elif Global.CameraView == 6:
		set_frame(6)
		CamBG.set_frame(6)
	elif Global.CameraView == 7:
		set_frame(7)
		CamBG.set_frame(7)
		if EnemyAI.SpringyLocation == 7:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam8.png")
			add_child(SpringyCam)
	elif Global.CameraView == 8:
		set_frame(8)
		CamBG.set_frame(8)
		if EnemyAI.SpringyLocation == 8:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam9.png")
			add_child(SpringyCam)
	elif Global.CameraView == 9:
		set_frame(9)
		CamBG.set_frame(9)
	elif Global.CameraView == 10:
		set_frame(10)
		CamBG.set_frame(10)
	elif Global.CameraView == 11:
		set_frame(11)
		CamBG.set_frame(11)
	elif Global.CameraView == 12:
		set_frame(12)
		CamBG.set_frame(12)
		if EnemyAI.SpringyLocation == 12:
			var SpringyCam = Sprite2D.new()
			SpringyCam.texture = preload("res://assets/SpringyCam13.png")
			add_child(SpringyCam)
	elif Global.CameraView == 13:
		set_frame(13)
		CamBG.set_frame(13)
	CamNum.text = "Cam " + str(Global.CameraView + 1)
