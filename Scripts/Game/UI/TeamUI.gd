extends VBoxContainer

@onready var TeamSlots = $GridContainer
@export var Team : Array[CharacterInfo]

func _ready():
	for x in range(0, len(TeamSlots.get_children())):
		if x < len(Team) and is_instance_valid(Team[x]):
			TeamSlots.get_child(x).Setup(Team[x])
		else:
			TeamSlots.get_child(x).Setup(null)
		
func GetUnits():
	return Team
