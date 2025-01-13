extends Node2D

class_name Character

@export var CharacterData : Unit

@export var bIsEnemy = false



func _ready():
	Setup()
	
func Setup():
	$CharacterUI.Setup(self)
	await $CharacterUI.Tell("")
	$CharacterUI.Tell("HELLO!!")

func GetHealthComponent() -> HealthComponent:
	return $HPComponent
