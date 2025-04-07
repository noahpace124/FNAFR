extends Node2D

@onready var BGChar = $BGChar

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	Global.next_scene = "res://scenes/loading.tscn"
	var char = rng.randi_range(0, 2)
	BGChar.frame = char

func _on_start_pressed() -> void:
	# Set EnemyAI Values
	EnemyAI.Springy["AI"] = 0
	EnemyAI.Lovely["AI"] = 0
	EnemyAI.Sneaky["AI"] = 0
	EnemyAI.Giggly["AI"] = 20
	EnemyAI.Sleepy["AI"] = 0
	EnemyAI.enemies = [EnemyAI.Giggly, EnemyAI.Sleepy]

	# Start loading the scene
	ResourceLoader.load_threaded_request(Global.next_scene)

	# Wait until the scene is loaded
	while ResourceLoader.load_threaded_get_status(Global.next_scene) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame  # Yield until the scene is loaded

	# Get the loaded PackedScene
	var packed_scene = ResourceLoader.load_threaded_get(Global.next_scene)
	get_tree().change_scene_to_packed(packed_scene)
	Global.next_scene = "res://scenes/night.tscn"
