extends Trait

class_name TraitExtraAttack

@export var ExecutionTiming : EXECUTION_TIME
@export var Chance = 25

func Setup():
	ExecutionType = ExecutionTiming
	
func Execute(charRef : Character):
	var result = randi() % 100
	if result <= Chance:
		charRef.Speak(Name)
		charRef.GetAI().SetAIState(AIController.AI_STATE.ATTACK)
		await charRef.GetAI().ActionComplete
		
