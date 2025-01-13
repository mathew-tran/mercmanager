extends Node

class_name HealthComponent

var Health = 0
var MaxHealth = 0

signal Update

func Setup(char : Character):
	Health = char.CharacterData.StatValues.HP
	MaxHealth = Health
	Update.emit()
	
func GetHealthString():
	return str(Health) + "/" + str(MaxHealth)
