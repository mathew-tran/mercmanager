extends Node2D

var Index = 0
var GroupList = []

func _ready():
	GroupList = Helper.GetAllFilePaths("res://Scripts/Data/DataType/EnemyGroup/")
	Index = 0
	
	print(GroupList[Index])

func GetUnits():
	return load(GroupList[Index]).Characters
