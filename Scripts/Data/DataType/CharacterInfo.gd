extends Resource

class_name CharacterInfo

@export var Name = "test"
@export var Face : Texture2D
@export var StatValues : Stats

@export var Moves : MoveList
@export var Cost = 1

var ActivationRange = 400

var GivenName = ""

@export var GivenNames = ""

func Setup():	
	var newNames = Array(GivenNames.split(", "))
	newNames.shuffle()
	GivenName = newNames[0]
	
	StatValues.HP += randi_range(1, 3)
	if randi_range(0, 100) > 70:
		StatValues.Damage += randi_range(1, 2)
		StatValues.HP += randi_range(1, 3)

func GetFullName():
	if GivenName == "":
		return Name
	return 	GivenName + " the "  + Name
