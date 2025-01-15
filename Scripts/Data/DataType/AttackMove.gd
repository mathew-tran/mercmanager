extends Move

class_name AttackMove

@export var BaseDamage = 1
@export var HitAmount = 1

func Execute(owner : Character, targets : Array[Character]):
	for x in range(0, HitAmount):
		for target in targets:
			if HasMoveSucceeded():
				await owner.get_tree().create_timer(.1).timeout
				await owner.Speak("")
				if is_instance_valid(Effect):
					await Effect.PlayEffect(owner, target)
				target.GetHealthComponent().TakeDamage(CalculateDamage(owner))
				await target.get_tree().create_timer(.2).timeout
			else:
				await target.get_tree().create_timer(.2).timeout
				

func CalculateDamage(owner: Character):
	var damage = BaseDamage	
	damage += owner.CharacterData.StatValues.Damage
	return damage
