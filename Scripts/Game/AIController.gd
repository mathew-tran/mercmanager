extends Node

class_name AIController

signal ActionComplete

var CharRef : Character
var bIsRunning = false
	
enum AI_STATE {
	ATTACK,
	RUN_AWAY
}

var CurrentState = AI_STATE.ATTACK

func Run():
	bIsRunning = true
	
	if CharRef.GetHealthComponent().GetHealthPercent() < .5:
		var result = randf_range(0, 100)
		if result > 50:
			CurrentState = AI_STATE.RUN_AWAY
		else:
			CurrentState = AI_STATE.ATTACK
			
	else:
		CurrentState = AI_STATE.ATTACK

	
func _process(delta):
	if bIsRunning:
		if CurrentState == AI_STATE.ATTACK:
			RunAttackAI(delta)
		if CurrentState == AI_STATE.RUN_AWAY:
			RunAwayAI(delta)
			
func RunAttackAI(delta):
	var nearestEnemy = Helper.GetClosestEnemy(CharRef)
	if is_instance_valid(nearestEnemy):
		if IsCloseToPosition(CharRef, nearestEnemy.global_position) == false:
			MoveToPosition(CharRef, nearestEnemy.global_position, delta)
		else:
			nearestEnemy.GetHealthComponent().TakeDamage(2)
			ActionComplete.emit()
	else:
		ActionComplete.emit()
		
func RunAwayAI(delta):
	var nearestEnemy = Helper.GetClosestEnemy(CharRef)
	if is_instance_valid(nearestEnemy):
		if IsCloseToPosition(CharRef, nearestEnemy.global_position):
			MoveAwayFromPosition(CharRef, nearestEnemy.global_position, delta)
		else:
			ActionComplete.emit()
	else:
		ActionComplete.emit()
		
func MoveToPosition(charRef: Character, newPosition, delta):
	var direction = (newPosition - charRef.global_position).normalized()
	charRef.global_position += direction * 400 * delta
	
func MoveAwayFromPosition(charRef: Character, newPosition, delta):
	var direction = (newPosition - charRef.global_position).normalized()
	charRef.global_position -= direction * 400 * delta

func IsCloseToPosition(charRef : Character, newPosition):
	return charRef.global_position.distance_to(newPosition) < charRef.CharacterData.ActivationRange
