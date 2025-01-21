extends Trait

class_name TraitRegenerate

func Setup():
	ExecutionType = EXECUTION_TIME.AFTER_ATTACK
	
func Execute(charRef : Character):
	charRef.GetHealthComponent().Heal(2)
