extends Resource

class_name Move

@export var Name = "test"
@export var PercentChance = 100
@export var MoveDescription = "MoveDecription"
@export var MoveRange = 100
@export var TimeToActive = .2
@export var Effect : MoveEffect

var Targets : Array[Character]

signal MoveCompleted

func AttemptToDoMove(owner : Character, targets):
	owner.Speak(Name)
	await owner.get_tree().create_timer(.5).timeout
	await Execute(owner, targets)
	
func HasMoveSucceeded():
	var result = randf_range(0, 100)
	return result <= PercentChance
	
func GetDamageValueText():
	return ""
	
func Execute(owner : Character, targets):
	pass
