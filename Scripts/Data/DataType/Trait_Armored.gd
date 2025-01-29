extends Trait

class_name TraitArmored


@export var HitAmount = 3
var MaxHitAmount = 0

func Setup():
	ExecutionType = EXECUTION_TIME.AFTER_HIT
	MaxHitAmount = HitAmount
	
func Execute(charRef : Character):
	HitAmount -= 1
	if HitAmount <= 0:
		charRef.Speak(Name)
		charRef.GetHealthComponent().SetArmored(true)
		var timer = charRef.get_tree().create_timer(1.0)
		await timer.timeout
		charRef.Speak("")
		HitAmount = MaxHitAmount
		timer = charRef.get_tree().create_timer(.25)
		await timer.timeout
