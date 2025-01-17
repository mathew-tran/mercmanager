extends Node2D

@onready var Characters = $Characters
@onready var PlayerSpawns = $PlayerSpawnPositions
@onready var EnemySpawns = $EnemySpawnPositions

enum GAME_STATE {
	PLAYING,
	PLAYER_WIN,
	PLAYER_LOSE
}

var CurrentState = GAME_STATE.PLAYING

func StartRound():
	SpawnInTeam(Character.TEAM.PLAYER)
	SpawnInTeam(Character.TEAM.ENEMY)
	
func SpawnInTeam(teamType):
	var units = []
	var spawnPositions = PlayerSpawns
	
	if teamType == Character.TEAM.PLAYER:
		units = Helper.GetPlayerResourceUnits()
	else:
		units = Helper.GetEnemyResourceUnits()
		spawnPositions = EnemySpawns
		
	for index in range(0, len(units)):
		if is_instance_valid(units[index]):
			var instance = load("res://Prefabs/Character.tscn")
			instance.CharacterData = units[index]
			instance.Team = teamType
			instance.global_position = spawnPositions.get_child(index).GetSpawnPosition()
			Characters.add_child(instance)
			
	
	
	
func PlayGame():
	var index = 0
	while CurrentState == GAME_STATE.PLAYING:
		Helper.GetFollowCamera().FocusObject(Characters.get_child(index))
		await Helper.GetFollowCamera().CloseToObject
		await Characters.get_child(index).RunInput()
		
		
		if IsPlayerDead():
			CurrentState = GAME_STATE.PLAYER_LOSE
			break
		
		if IsEnemyDead():
			CurrentState = GAME_STATE.PLAYER_WIN
			break
			
		index += 1
		if index >= len(Characters.get_children()):
				index = 0
				
		while IsUnitAlive(index) == false:
			index += 1
			if index >= len(Characters.get_children()):
				index = 0
		
		
				
		await get_tree().create_timer(.5).timeout
		
	
func IsUnitAlive(index):
	return Characters.get_child(index).GetHealthComponent().IsAlive()
	
func IsPlayerDead():
	var units = Helper.GetPlayerTeamUnits()
	for unit in units:
		if unit.GetHealthComponent().IsAlive():
			return false
	return true
	
func IsEnemyDead():
	var units = Helper.GetOpponentTeamUnits()
	for unit in units:
		if unit.GetHealthComponent().IsAlive():
			return false
	return true
