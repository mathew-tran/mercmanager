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
	if Health <= 0:
		return "KO"
	return str(Health) + "/" + str(MaxHealth)

func GetHealthPercent() -> float:
	return float(Health) / float(MaxHealth)

func TakeDamage(amount):
	Health -= amount
	Update.emit()

func IsAlive():
	return Health > 0
