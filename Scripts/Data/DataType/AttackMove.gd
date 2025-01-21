extends Move

class_name AttackMove

@export var BaseDamage = 1
@export var DamageRange = 0
@export var HitAmount = 1

func Execute(owner : Character, targets : Array[Character]):
	if HasMoveSucceeded():
		for x in range(0, HitAmount):
			for target in targets:
				if owner.GetHealthComponent().IsAlive() == false: # This is to cover incase target retaliates or move hurts user
					return
					
				if HasMoveSucceeded() or x == 0:
					Helper.GetFocusPoint().global_position = lerp(owner.global_position, target.global_position, .5)
					await Helper.GetFollowCamera().FocusObject(Helper.GetFocusPoint())
					await owner.get_tree().create_timer(.1).timeout
					await owner.Speak("")
					if is_instance_valid(Effect):
						await Effect.PlayEffect(owner, target)
					target.GetHealthComponent().TakeDamage(CalculateDamage(owner))
					await target.get_tree().create_timer(.2).timeout
					
				else:
					await target.get_tree().create_timer(.2).timeout
				
				if target.GetHealthComponent().IsAlive():
					await target.GetAI().RunTrait(Trait.EXECUTION_TIME.AFTER_HIT)
	else:
		await owner.Speak("MISSED")
		await owner.get_tree().create_timer(.4).timeout
		await owner.Speak("")		

func CalculateDamage(owner: Character):
	var damage = BaseDamage	
	damage += randi_range(0, DamageRange)
	damage += owner.CharacterData.StatValues.Damage
	return damage

func GetDamageValueText():
	return str(BaseDamage) + " - " + str(BaseDamage + DamageRange)
