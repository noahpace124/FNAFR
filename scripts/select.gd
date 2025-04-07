extends Node2D

@onready var options = $GUI/EnemyOptions
@onready var description = $GUI/EnemyDescription
@onready var enemies = $GUI/Enemies

var currentX = 25

var numEnemies = 0
var currentEnemy = null
var selectedEnemies = []

func _ready() -> void:
	if Global.Night == 1:
		numEnemies = 2
	elif Global.Night <= 5:
		numEnemies = 1
	for enemy in EnemyAI.inactive:
		var option = Button.new()
		option.text = enemy["Name"]
		option.position.y = 25
		option.position.x = currentX
		currentX += 75
		option.pressed.connect(on_button_pressed.bind(enemy))
		options.add_child(option)
		
func on_button_pressed(enemy_data):
	currentEnemy = enemy_data
	description.text = enemy_data["Desc"]

func _on_add_pressed() -> void:
	if currentEnemy != null:
		for enemy in selectedEnemies:
			if enemy["Name"] == currentEnemy["Name"]:
				return
		selectedEnemies.append(currentEnemy)

func list_selected() -> void:
	enemies.text = ""
	for enemy in selectedEnemies:
		enemies.text += enemy["Name"] + " "

func _process(delta: float) -> void:
	list_selected()
	if selectedEnemies.size() == numEnemies:
		#init night or go to pro/con
		for enemy in EnemyAI.inactive:
			for selectedEnemy in selectedEnemies:
				if enemy == selectedEnemy:
					EnemyAI.inactive.erase(selectedEnemy)
					EnemyAI.enemies.append(selectedEnemy)
		get_tree().quit()
