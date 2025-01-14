extends Node


func GetEnemyUnits(charRef : Character):
	var enemies = []
	var units = get_tree().get_nodes_in_group("Unit")
	for unit in units:
		if unit.Team != charRef.Team and unit != charRef:
			enemies.append(unit)
	return enemies
	
func GetAllyUnits(charRef : Character):
	var enemies = []
	var units = get_tree().get_nodes_in_group("Unit")
	for unit in units:
		if unit.Team == charRef.Team and unit != charRef:
			enemies.append(unit)
	return enemies

func GetClosestEnemy(charRef: Character) -> Character:
	var enemyUnits = GetEnemyUnits(charRef)
	if len(enemyUnits) == 0:
		return null
	var closestEnemy = enemyUnits[0]
	var closestDistance = charRef.global_position.distance_to(closestEnemy.global_position)
	for enemy in enemyUnits:
		var distance = enemy.global_position.distance_to(charRef.global_position)
		if distance < closestDistance:
			closestDistance = distance
			closestEnemy = enemy
	return closestEnemy
		
