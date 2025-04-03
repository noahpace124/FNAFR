extends Node2D

func _ready() -> void:
	Global.next_scene = "res://scenes/loading.tscn"

func _on_start_pressed() -> void:
	# Set EnemyAI Values
	EnemyAI.Springy["AI"] = 5
	EnemyAI.Lovely["AI"] = 5
	EnemyAI.enemies = [EnemyAI.Springy, EnemyAI.Lovely]

	# Start loading the scene
	ResourceLoader.load_threaded_request(Global.next_scene)

	# Wait until the scene is loaded
	while ResourceLoader.load_threaded_get_status(Global.next_scene) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame  # Yield until the scene is loaded

	# Get the loaded PackedScene
	var packed_scene = ResourceLoader.load_threaded_get(Global.next_scene)
	get_tree().change_scene_to_packed(packed_scene)	
	Global.next_scene = "res://scenes/night.tscn"
