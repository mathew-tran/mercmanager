extends Node

class_name HealthComponent

var Health = 0
var MaxHealth = 0

signal Update
signal TakenDamage
signal OnDeath
var CharRef : Character
func Setup(char : Character):
	Health = char.CharacterData.StatValues.HP
	MaxHealth = Health
	CharRef = char
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
	TakenDamage.emit()
	Helper.CreateText(amount, get_parent().global_position)
	if IsAlive() == false:
		OnDeath.emit()
	
	print(CharRef.CharacterData.GetFullName() + " takes " + str(amount) + " damage")

func IsAlive():
	return Health > 0
