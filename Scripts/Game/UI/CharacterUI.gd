extends Control

var CharacterRef : Character

func Setup(char : Character):
	CharacterRef = char
	$Face.texture = char.CharacterData.Face
	$Name.text = char.CharacterData.Name
	char.GetHealthComponent().Setup(char)
	char.GetHealthComponent().Update.connect(OnUpdate)
	char.GetHealthComponent().OnDeath.connect(OnDeath)
	if char.Team == Character.TEAM.ENEMY:
		$Frame.modulate = "c93864ff"
	else:
		$Frame.modulate = "35cbc8ff"
	OnUpdate()
	
func OnUpdate():
	$HP/Label.text = CharacterRef.GetHealthComponent().GetHealthString()
	$HP.value = CharacterRef.GetHealthComponent().GetHealthPercent() * 100
	
func OnDeath():
	$Face.rotation_degrees = 90
	modulate = "737373"
	CharacterRef.z_as_relative = false
	CharacterRef.z_index = -100
	
func Tell(message):
	if message != "":
		await $SpeechBubble.Show(message)
	else:
		await $SpeechBubble.Hide()
