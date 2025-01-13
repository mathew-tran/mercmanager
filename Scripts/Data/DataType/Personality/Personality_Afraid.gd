extends Personality

enum STATE {
	RUN_AWAY,
	ATTACK
}
func Run(charRef : Character, delta):
	var nearestEnemy = Helper.GetClosestEnemy(charRef)
	if is_instance_valid(nearestEnemy):
		if IsCloseToPosition(charRef, nearestEnemy.global_position) == false:
			MoveToPosition(charRef, nearestEnemy.global_position, delta)
