extends Node

func GetPlayerTeamUnits():
	var enemies = []
	var units = get_tree().get_nodes_in_group("Unit")
	for unit in units:
		if unit.Team == Character.TEAM.PLAYER:
			enemies.append(unit)
	return enemies
	
func GetOpponentTeamUnits():
	var enemies = []
	var units = get_tree().get_nodes_in_group("Unit")
	for unit in units:
		if unit.Team == Character.TEAM.ENEMY:
			enemies.append(unit)
	return enemies
	
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

func GetClosestEnemy(charRef: Character, bIsAlive = true) -> Character:
	var enemyUnits = GetEnemyUnits(charRef)
	if len(enemyUnits) == 0:
		return null
	var closestEnemy = null
	for enemy in enemyUnits:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			closestEnemy = enemy
			break
	var closestDistance = charRef.global_position.distance_to(closestEnemy.global_position)
	for enemy in enemyUnits:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			var distance = enemy.global_position.distance_to(charRef.global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestEnemy = enemy
	return closestEnemy
		
func GetFollowCamera() -> FollowCamera:
	var camera = get_tree().get_nodes_in_group("FollowCamera")
	if camera:
		return camera[0]
	return null
