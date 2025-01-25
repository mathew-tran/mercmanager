extends Control

@onready var EnemyContainer = $VBoxContainer/HBoxContainer

func _ready():
	Helper.GetEnemySpawner().EnemySpawnerUpdate.connect(OnEnemySpawnerUpdate)
	
func OnEnemySpawnerUpdate():
	UpdateEnemyList(Helper.GetEnemySpawner().GetGroup())
	
func UpdateEnemyList(enemyGroup : EnemyGroup):
	for child in EnemyContainer.get_children():
		child.queue_free()
		
	for character in enemyGroup.Characters:
		var instance = load("res://Prefabs/UI/EnemyMemberSlot.tscn").instantiate()
		instance.Setup(character)
		EnemyContainer.add_child(instance)
		
