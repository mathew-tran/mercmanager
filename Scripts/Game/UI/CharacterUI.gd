extends Control

var CharacterRef : Character

func Setup(char : Character):
	CharacterRef = char
	$Face.texture = char.CharacterData.Face
	$ActiveUI/Name.text = char.CharacterData.GetFullName()
	$ActiveUI/Frame.UpdateFrame(char)
	char.GetHealthComponent().Setup(char)
	char.GetHealthComponent().Update.connect(OnUpdate)
	char.GetHealthComponent().OnDeath.connect(OnDeath)
	char.GetHealthComponent().Armored.connect(OnArmored)
		
	$ActiveUI/Frame.ShowRarity(char.Team == Character.TEAM.PLAYER)
	OnUpdate()
	SetActive(false)
	
func SetActive(bActive):
	$ActiveUI.visible = bActive
	
func OnArmored(bArmored):
	$Statuses/Shielded.visible = bArmored
	
func OnUpdate():
	$ActiveUI/HP/Label.text = CharacterRef.GetHealthComponent().GetHealthString()
	$ActiveUI/HP.value = CharacterRef.GetHealthComponent().GetHealthPercent() * 100
	
func OnDeath():
	$Face.rotation_degrees = randf_range(0, 360)
	$Face.flip_h = randi() % 1
	modulate = "737373"
	CharacterRef.z_as_relative = false
	CharacterRef.z_index = -100
	$ActiveUI.visible = false
	
func Tell(message):
	if message != "":
		await $SpeechBubble.Show(message)
	else:
		await $SpeechBubble.Hide()
