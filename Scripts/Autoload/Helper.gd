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

func GetEffectsGroup():
	var effects = get_tree().get_nodes_in_group("Effects")
	if effects:
		return effects[0]
	return null
	
	
func CreateText(text, position):
	var instance = load("res://Prefabs/UI/DamageText.tscn").instantiate()
	instance.Setup(text)
	instance.global_position = position
	GetEffectsGroup().add_child(instance)
	
func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths

func GetPlayerResourceUnits():
	var result = get_tree().get_nodes_in_group("PlayerTeam")
	return result[0].GetUnits()
	
func GetEnemyResourceUnits():
	var result = get_tree().get_nodes_in_group("EnemySpawner")
	return result[0].GetUnits()

func GetBattleSystem() -> BattleSystem:
	return get_tree().get_nodes_in_group("BattleSystem")[0]

func GetShop() -> Shop:
	return get_tree().get_nodes_in_group("Shop")[0]

func GetPlayerTeam() -> PlayerTeam:
	var result = get_tree().get_nodes_in_group("PlayerTeam")
	return result[0]

func GetCharInfoUI() -> CharacterInfoUI:
	var result = get_tree().get_nodes_in_group("CharacterInfoUI")
	if result:
		return result[0]
	return null
