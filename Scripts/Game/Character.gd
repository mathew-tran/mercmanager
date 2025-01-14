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
	$ActiveSymbol.visible = true
	print(name + "(" + CharacterData.Name + " is running)")
	await get_tree().create_timer(.3).timeout
	$AIController.Run()
	await $AIController.ActionComplete
	
	$AIController.bIsRunning = false
	await get_tree().create_timer(.1).timeout
	$ActiveSymbol.visible = false
