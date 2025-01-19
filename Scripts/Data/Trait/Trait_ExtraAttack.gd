extends Trait

class_name TraitExtraAttack

@export var ExecutionTiming : EXECUTION_TIME

func Setup():
	ExecutionType = ExecutionTiming
	
func Execute(charRef : Character):
	charRef.GetAI().SetAIState(AIController.AI_STATE.ATTACK)
	await charRef.GetAI().ActionComplete
