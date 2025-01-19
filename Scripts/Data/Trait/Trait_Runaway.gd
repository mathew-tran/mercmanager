extends Trait

class_name TraitRunAway

func Setup():
	ExecutionType = EXECUTION_TIME.AFTER_ATTACK
	
func Execute(charRef : Character):
	charRef.GetAI().SetAIState(AIController.AI_STATE.RUN_AWAY)
	await charRef.GetAI().ActionComplete
