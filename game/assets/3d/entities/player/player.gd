extends RigidBody3D

class_name Player

var move_speed := 1400.0

@onready var animator := $player_model/AnimationPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")

	if input == Vector3.ZERO:
		animator.play("Idle")
	else:
		animator.play("Walk")

	apply_central_force(input.normalized() * move_speed * delta)
