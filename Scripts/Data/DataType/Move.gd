extends Resource

class_name Move

@export var Name = "test"
@export var PercentChance = 100
@export var MoveDescription = "MoveDecription"
@export var MoveRange = 100
@export var TimeToActive = .2

signal MoveCompleted

func HasMoveSucceeded():
	var result = randf_range(0, 100)
	return result <= PercentChance
	
func Execute():
	pass
