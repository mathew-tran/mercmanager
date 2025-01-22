extends Resource

class_name Trait

@export var Name = ""
@export var Description = ""

enum EXECUTION_TIME {
	AFTER_ATTACK,
	AFTER_HIT
}

var ExecutionType : EXECUTION_TIME

func GetTraitText():
	return "[" + Name + "] " + Description
	
func Execute(charRef : Character):
	pass
