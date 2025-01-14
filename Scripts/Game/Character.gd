extends Node2D

class_name Character

@export var CharacterData : CharacterInfo

@export var Team : TEAM

enum TEAM {
	PLAYER,
	ENEMY
}

func _ready():
	Setup()
	
func Setup():
	$CharacterUI.Setup(self)
	$AIController.CharRef = self
	await $CharacterUI.Tell("")

func GetHealthComponent() -> HealthComponent:
	return $HPComponent
	
func RunInput():
	print(name + "(" + CharacterData.Name + " is running)")
	$AIController.Run()
	await $AIController.ActionComplete
	$AIController.bIsRunning = false
