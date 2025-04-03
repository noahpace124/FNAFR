extends Node2D

@onready var label = $Screen/Label
@onready var timer = $Screen/Timer
@onready var SFX = $Screen/Music

var speed = 2
var minY = 150

var curTime = 0.0
var maxTime = 3.0

func _ready() -> void:
	SFX.stream = preload("res://assets/audio/Fanfare.mp3")
	SFX.play()

func _process(delta: float) -> void:
	if label.position.y != minY:
		label.position.y -= speed


func _on_timer_timeout() -> void:
	curTime += 0.5
	label.visible = !label.visible
	if curTime == maxTime:
		timer.wait_time = 2
	elif curTime > maxTime:
		# Start loading the scene
		ResourceLoader.load_threaded_request(Global.next_scene)

		# Wait until the scene is loaded
		while ResourceLoader.load_threaded_get_status(Global.next_scene) != ResourceLoader.THREAD_LOAD_LOADED:
			await get_tree().process_frame  # Yield until the scene is loaded

		# Get the loaded PackedScene
		var packed_scene = ResourceLoader.load_threaded_get(Global.next_scene)
		get_tree().change_scene_to_packed(packed_scene)	
		Global.next_scene = "res://scenes/title.tscn"
		return
	timer.start()
