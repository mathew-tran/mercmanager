extends Trait

class_name TraitPlunder

@export var ExecutionTiming : EXECUTION_TIME
@export var Chance = 100
@export var GoldAmount = 1

func Setup():
	ExecutionType = ExecutionTiming
	
func Execute(charRef : Character):
	var result = randi() % 100
	if result <= Chance:
		charRef.Speak(Name)
		Helper.GetShop().AddMoney(GoldAmount)
		print("Gain " + str(GoldAmount) + " from " + str(Name))
		var text = "+" + str(GoldAmount) + " GOLD"
		var textObject = Helper.CreateText(text, charRef.global_position)
		await textObject.Complete
		
