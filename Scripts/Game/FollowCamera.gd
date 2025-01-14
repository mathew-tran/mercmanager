extends Camera2D

class_name FollowCamera

var ObjectToFollow = null
var CameraSpeed = 400

signal CloseToObject
func FocusObject(obj):
	ObjectToFollow = obj
	
func _process(delta):
	if is_instance_valid(ObjectToFollow):
		if ObjectToFollow.global_position.distance_to(global_position) > 20:
			var direction = (ObjectToFollow.global_position - global_position).normalized()
			global_position += direction * CameraSpeed * delta
		else:
			CloseToObject.emit()
