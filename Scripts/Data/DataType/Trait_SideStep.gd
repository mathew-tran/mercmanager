extends Trait

class_name TraitSideStep

@export var ExecutionTiming : EXECUTION_TIME

func Setup():
	ExecutionType = ExecutionTiming
	
func Execute(charRef : Character):
	var ally = Helper.GetRandomAlly(charRef, true)
	if is_instance_valid(ally):
		charRef.Speak(Name)
		var tween = charRef.create_tween()
		tween.tween_property(charRef, "global_position", ally.global_position, .5)
		await tween.finished
