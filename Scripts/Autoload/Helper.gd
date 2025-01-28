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
	
func GetRandomAlly(charRef: Character, bIsAlive = true):
	var units = GetAllyUnits(charRef)
	var chosenUnits = []
	for unit in units:
		if unit.GetHealthComponent().IsAlive() == bIsAlive:
			chosenUnits.append(unit)
			
	if len(chosenUnits) <= 0:
		return null
		
	chosenUnits.shuffle()
	return chosenUnits[0]
	

func GetClosestUnitInGroup(enemyGroup, charRef: Character, bIsAlive = true) -> Character:
	var closestEnemy = null
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			closestEnemy = enemy
			break
	if closestEnemy == null:
		return null
	var closestDistance = charRef.global_position.distance_to(closestEnemy.global_position)
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			var distance = enemy.global_position.distance_to(charRef.global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestEnemy = enemy
	return closestEnemy
	
func GetLowestHPUnitInGroup(enemyGroup, charRef: Character, bIsAlive = true) -> Character:
	var chosenEnemy = null
	var lowestHealth = 999999999
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			chosenEnemy = enemy
			lowestHealth = chosenEnemy.GetHealthComponent().Health
			break
	if chosenEnemy == null:
		return null
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			var currentHealth = enemy.GetHealthComponent().Health
			if lowestHealth > currentHealth:
				lowestHealth = currentHealth
				chosenEnemy = enemy
	return chosenEnemy
	
func GetHighestHPUnitInGroup(enemyGroup, charRef: Character, bIsAlive = true) -> Character:
	var chosenEnemy = null
	var highestHealth = -999999999
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			chosenEnemy = enemy
			highestHealth = chosenEnemy.GetHealthComponent().Health
			break
	if chosenEnemy == null:
		return null
	for enemy in enemyGroup:
		if enemy.GetHealthComponent().IsAlive() == bIsAlive:
			var currentHealth = enemy.GetHealthComponent().Health
			if highestHealth < currentHealth:
				highestHealth = currentHealth
				chosenEnemy = enemy
	return chosenEnemy

func GetHighestHPEnemy(charRef: Character, bIsAlive = true) -> Character:
	var enemyUnits = GetEnemyUnits(charRef)
	if len(enemyUnits) == 0:
		return null
	return GetHighestHPUnitInGroup(enemyUnits, charRef, bIsAlive)
		
func GetLowestHPEnemy(charRef: Character, bIsAlive = true) -> Character:
	var enemyUnits = GetEnemyUnits(charRef)
	if len(enemyUnits) == 0:
		return null
	return GetLowestHPUnitInGroup(enemyUnits, charRef, bIsAlive)
	
func GetClosestEnemy(charRef: Character, bIsAlive = true) -> Character:
	var enemyUnits = GetEnemyUnits(charRef)
	if len(enemyUnits) == 0:
		return null
	return GetClosestUnitInGroup(enemyUnits, charRef, bIsAlive)
		
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

func GetEnemySpawner():
	var result = get_tree().get_nodes_in_group("EnemySpawner")
	return result[0]
	
func GetCharacterHolder():
	var result = get_tree().get_nodes_in_group("CharacterHolder")
	return result
	
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

func GetFocusPoint():
	var result = get_tree().get_nodes_in_group("FocusPoint")
	if result:
		return result[0]
	return null

func RestartGame():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("restart"):
		RestartGame()
	
