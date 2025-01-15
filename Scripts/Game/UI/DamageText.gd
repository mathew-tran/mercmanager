extends Node2D


func Setup(amount):
	$Control.text = str(amount)
	
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property($Control, "global_position", $Control.global_position - Vector2(0, 200), 1.0)
	await tween.finished
	queue_free()
