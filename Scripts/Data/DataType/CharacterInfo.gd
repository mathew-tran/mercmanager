extends Resource

class_name CharacterInfo

@export var Name = "test"
@export var Face : Texture2D
@export var StatValues : Stats

@export var Moves : MoveList
@export var Cost = 1
@export var UpgradeCost = 1
@export var Traits : Array[Trait]
@export var Rarity : RARITY

enum RARITY {
	NORMAL,
	RARE,
	LEGENDARY
}

var ActivationRange = 400

var GivenName = ""

@export var GivenNames = ""

func Setup():	
	var newNames = Array(GivenNames.split(", "))
	newNames.shuffle()
	GivenName = newNames[0]
	
	StatValues.HP += randi_range(1, 5)
	if randi_range(0, 100) > 70:
		StatValues.Damage += randi_range(1, 3)
		StatValues.HP += randi_range(1, 4)
	
	var lastingTraits : Array[Trait]
	var chanceToLose = randi_range(10, 50)
	if Rarity == RARITY.RARE:
		chanceToLose -= 20
	elif Rarity == RARITY.LEGENDARY:
		chanceToLose -= 30
	for charTrait in Traits:
		var result = randi_range(0, 100)
		if result <= chanceToLose:
			lastingTraits.append(charTrait)
			chanceToLose += 20
			Cost += 1
		
	Traits = lastingTraits
			

func GetFullName():
	if GivenName == "":
		return Name
	return 	Name +  " " + GivenName
