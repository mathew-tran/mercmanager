extends Sprite2D

var TargetPosition
var Duration = .5

signal Complete
func Setup(targetPosition, duration, objectTexture):
	TargetPosition = targetPosition	
	Duration = duration
	texture = objectTexture
	
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", TargetPosition, Duration)
	rotation = (TargetPosition - global_position).angle()
	print(rotation_degrees)
	await tween.finished
	Complete.emit()
	queue_free()
