extends Trait

class_name TraitRegenerate

func Setup():
	ExecutionType = EXECUTION_TIME.AFTER_ATTACK
	
func Execute(charRef : Character):
	charRef.Speak(Name)
	charRef.GetHealthComponent().Heal(2)
	var timer = charRef.get_tree().create_timer(1.0)
	await timer.timeout
	charRef.Speak("")
