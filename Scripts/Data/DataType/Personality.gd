extends Resource

class_name Personality

@export var Name = "test"
@export var Description = "s"

func Run(charRef : Character, delta):
	pass

func MoveToPosition(charRef: Character, newPosition, delta):
	var direction = (newPosition - charRef.global_position).normalized()
	charRef.global_position += direction * charRef.CharacterData.StatValues.Speed * delta

func IsCloseToPosition(charRef : Character, newPosition):
	return charRef.global_position.distance_to(newPosition) < charRef.CharacterData.ActivationRange
