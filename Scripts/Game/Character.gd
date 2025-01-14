extends Node2D

class_name Character

@export var CharacterData : CharacterInfo

@export var Team : TEAM

enum TEAM {
	PLAYER,
	ENEMY
}

signal CompletedTakingDamage

func _ready():
	Setup()
	
func Setup():
	$CharacterUI.Setup(self)
	$AIController.CharRef = self
	$HPComponent.TakenDamage.connect(OnTakenDamage)


func OnTakenDamage():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * .4, .1)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, .1)
	await tween.finished
	CompletedTakingDamage.emit()
	
func Speak(message):
	$CharacterUI.Tell(message)

func GetHealthComponent() -> HealthComponent:
	return $HPComponent
	
func RunInput():
	$ActiveSymbol.visible = true
	print(name + "(" + CharacterData.Name + " is running)")
	await get_tree().create_timer(.1).timeout
	$AIController.Decide()
	$AIController.Telegraph()
	await get_tree().create_timer(.5).timeout
	$AIController.Run()
	await $AIController.ActionComplete
	
	$AIController.bIsRunning = false
	Speak("")
	await get_tree().create_timer(.1).timeout
	await Speak("")
	$ActiveSymbol.visible = false
