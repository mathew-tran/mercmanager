extends Node

class_name HealthComponent

var Health = 0
var MaxHealth = 0

signal Update
signal TakenDamage
signal OnDeath
signal Armored(bSet)
var CharRef : Character

var bIsArmored = false

func Setup(char : Character):
	Health = char.CharacterData.StatValues.HP
	MaxHealth = Health
	CharRef = char
	Update.emit()
	SetArmored(false)
	
func GetHealthString():
	if Health <= 0:
		return "KO"
	return str(Health) + "/" + str(MaxHealth)

func GetHealthPercent() -> float:
	return float(Health) / float(MaxHealth)

func Heal(amount):
	Health += amount
	if Health >= MaxHealth:
		Health = MaxHealth
	Update.emit()
	
func TakeDamage(amount):
	if bIsArmored:
		bIsArmored = false
		amount /= 2
		amount = round(amount)
		Armored.emit(bIsArmored)
	Health -= amount
	Update.emit()
	TakenDamage.emit()
	Helper.CreateText(amount, get_parent().global_position)
	if IsAlive() == false:
		OnDeath.emit()
	
	print(CharRef.CharacterData.GetFullName() + " takes " + str(amount) + " damage")

func IsArmored():
	return bIsArmored
	
func SetArmored(bSet):
	bIsArmored = bSet
	Armored.emit(bIsArmored)
	
func IsAlive():
	return Health > 0
