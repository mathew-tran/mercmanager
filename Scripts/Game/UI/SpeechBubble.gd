extends TextureRect

signal Finished

func Show(text):
	visible = true
	var tween = get_tree().create_tween()
	$Label.text = text
	tween.tween_property(self, "scale", Vector2.ONE, .2)
	await tween.finished

	
func Hide():
	var tween = get_tree().create_tween()
	$Label.text = ""
	tween.tween_property(self, "scale", Vector2(1,0), .1)
	await tween.finished
	visible = false
	
