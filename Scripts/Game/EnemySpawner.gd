extends Node2D

var Index = 0
var GroupList = []

signal EnemySpawnerUpdate

func _ready():
	GroupList = Helper.GetAllFilePaths("res://Scripts/Data/DataType/EnemyGroup/")
	Index = 0
	
	print(GroupList[Index])
	EnemySpawnerUpdate.emit()

func GetUnits():
	return load(GroupList[Index]).Characters

func GetGroup():
	return load(GroupList[Index])

func Increment():
	Index += 1
	if Index >= len(GroupList):
		Index = Index - 1
	EnemySpawnerUpdate.emit()
