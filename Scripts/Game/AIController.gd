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
var MoveToUse : Move
func Decide():
	
	if CharRef.GetHealthComponent().GetHealthPercent() < .5:
		var result = randf_range(0, 100)
		if result > 80:
			CurrentState = AI_STATE.RUN_AWAY
		else:
			CurrentState = AI_STATE.ATTACK
			
	else:
		CurrentState = AI_STATE.ATTACK
		
	if CurrentState == AI_STATE.ATTACK:
		MoveToUse = CharRef.CharacterData.Moves.DecideRandomMove()
	else:
		Cleanup()
	
func Telegraph():
	
	match CurrentState:
		AI_STATE.ATTACK:
			pass
		AI_STATE.RUN_AWAY:
			CharRef.Speak("TACTICAL RETREAT!")

func Run():
	bIsRunning = true
	
func _process(delta):
	if bIsRunning:
		if CurrentState == AI_STATE.ATTACK:
			RunAttackAI(delta)
		if CurrentState == AI_STATE.RUN_AWAY:
			RunAwayAI(delta)
			
func RunAttackAI(delta):
	if is_instance_valid(MoveToUse) == false:
		ActionComplete.emit()
		return
	var validTargets = MoveToUse.GetTargets(CharRef)
	
	if len(validTargets) > 0 and validTargets[0] != null:
		var nearestEnemy = Helper.GetClosestUnitInGroup(validTargets, CharRef, true)
		if IsCloseToPosition(CharRef, nearestEnemy.global_position) == false:
			MoveToPosition(CharRef, nearestEnemy.global_position, delta)
		else:
			bIsRunning = false
			await MoveToUse.AttemptToDoMove(CharRef, validTargets)
			ActionComplete.emit()
	else:
		ActionComplete.emit()

func SetAIState(aiState : AI_STATE):
	CurrentState = aiState
	bIsRunning = true
	if CurrentState == AI_STATE.ATTACK:
		MoveToUse = CharRef.CharacterData.Moves.DecideRandomMove()
	
func RunTrait(traitType : Trait.EXECUTION_TIME, bIsAliveCheck = true):
	for charTrait in CharRef.CharacterData.Traits:
		if charTrait.ExecutionType == traitType:
			if bIsAliveCheck:
				if CharRef.GetHealthComponent().IsAlive() == false:
					return
			CharRef.GetAI().Cleanup()
			print(CharRef.CharacterData.GetFullName() +  " runs trait " + charTrait.GetTraitText())

			await charTrait.Execute(CharRef)
	
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
	charRef.global_position += direction * 600 * delta
	
func MoveAwayFromPosition(charRef: Character, newPosition, delta):
	var direction = (newPosition - charRef.global_position).normalized()
	charRef.global_position -= direction * 600 * delta

func IsCloseToPosition(charRef : Character, newPosition):
	if is_instance_valid(MoveToUse):
		return charRef.global_position.distance_to(newPosition) < MoveToUse.MoveRange
	else:
		return charRef.global_position.distance_to(newPosition) < 400
		
func Cleanup():
	MoveToUse = null
