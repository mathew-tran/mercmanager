extends Area2D

var charHovered : Character

func _process(delta):
	global_position = get_global_mouse_position()
	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.get_parent() is Character:
			charHovered = body.get_parent()
			break
	if len(bodies) == 0:
		charHovered = null
		
func _input(event):
	if event.is_action_released("right_click"):
		if is_instance_valid(charHovered):
			Helper.GetCharInfoUI().UpdateInfo(charHovered.CharacterData)
