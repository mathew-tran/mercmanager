extends VBoxContainer

class_name PlayerTeam

@onready var TeamSlots = $GridContainer
@export var Team : Array[CharacterInfo]

var TeamSize = 6
signal TeamUpdate
		
func _ready():
	while len(Team) < TeamSize:
		Team.append(null)
		
	for child in TeamSlots.get_children():
		child.queue_free()
		
	for x in range(0, TeamSize):
		var instance = load("res://Prefabs/UI/TeamMemberSlot.tscn").instantiate()
		TeamSlots.add_child(instance)
		
		
	UpdateTeam()


func UpdateTeam():		
	for x in range(0, len(TeamSlots.get_children())):
		if x < len(Team) and is_instance_valid(Team[x]):
			TeamSlots.get_child(x).Setup(Team[x], x)
		else:
			TeamSlots.get_child(x).Setup(null, -1)
	
func GetUnits():
	return Team

func IsFull():
	for char in Team:
		if is_instance_valid(char) == false:
			return false
	return true

func AddPog(charInfo : CharacterInfo):
	for index in range(0, len(Team)):
		if is_instance_valid(Team[index]) == false:
			Team[index] = charInfo
			break
	UpdateTeam()
	TeamUpdate.emit()

func RemovePog(index):
	if is_instance_valid(Team[index]):
		Team[index] = null
		UpdateTeam()
		TeamUpdate.emit()
