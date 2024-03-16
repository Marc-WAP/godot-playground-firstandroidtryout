extends Node3D

class_name Finish

## Signals emited by the finish line
signal finish_activated()


##
## If the player walks through the finish line
##
func _on_area_3d_body_entered(body):
	if body is Player:
		finish_activated.emit()
