extends Node2D

class_name Character

@export var CharacterData : CharacterInfo

@export var Team : TEAM

enum TEAM {
	PLAYER,
	ENEMY
}

signal CompletedTakingDamage
signal ActiveUpdate(bActive)

var bHovered = false

func _ready():	
	Setup()
	
func Setup():
	$CharacterUI.Setup(self)
	$AIController.CharRef = self
	$HPComponent.TakenDamage.connect(OnTakenDamage)
	$HPComponent.OnDeath.connect(OnDeath)
	show_behind_parent = true
	
	CharacterData.Traits = CharacterData.Traits.duplicate(true)
	for charTrait in CharacterData.Traits:
		charTrait.Setup()
	
func OnDeath():
	$HitParticle.emitting = true
	
func GetAI() -> AIController:
	return $AIController
			
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
	ActiveUpdate.emit(true)
	$ActiveSymbol.visible = true
	ShowUI(true)
	show_behind_parent = true
	print(name + "(" + CharacterData.Name + " is running)")
	await get_tree().create_timer(.1).timeout
	$AIController.Decide()
	$AIController.Telegraph()
	await get_tree().create_timer(.4).timeout
	$AIController.Run()
	await $AIController.ActionComplete
	await RunTraitType(Trait.EXECUTION_TIME.AFTER_ATTACK, true)
	
	$AIController.bIsRunning = false
	Speak("")
	await get_tree().create_timer(.1).timeout
	await Speak("")
	$ActiveSymbol.visible = false
	show_behind_parent = false
	ShowUI(false)
	ActiveUpdate.emit(false)

func ShowUI(bShow):
	if bShow == false:
		$HideUITimer.start()
	else:
		$HideUITimer.stop()
		$CharacterUI.SetActive(true)
	
	
func RunTraitType(executionType : Trait.EXECUTION_TIME, bAliveCheck = true)	:
	await $AIController.RunTrait(executionType, bAliveCheck)


func _on_timer_timeout():
	$CharacterUI.SetActive(false)
