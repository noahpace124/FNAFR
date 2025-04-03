extends Node2D

func _on_start_pressed() -> void:
	var next_scene = load("res://scenes/night.tscn").instantiate()
	EnemyAI.enemies = [EnemyAI.Springy]
	get_tree().root.add_child(next_scene)
	queue_free()
