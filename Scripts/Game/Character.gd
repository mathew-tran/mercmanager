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
	await $CharacterUI.Tell("")

func GetHealthComponent() -> HealthComponent:
	return $HPComponent
	
func _process(delta):
	$AIController.Run(self, delta)
