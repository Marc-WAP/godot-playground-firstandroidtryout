extends Node3D

class_name Gate

## Signals emited by the gates
signal gate_activated(points: int)

## Materials used by the gates
static var material_empty = preload("res://assets/3d/entities/gates/materials/gate_empty.tres")
static var material_blue = preload("res://assets/3d/entities/gates/materials/gate_blue.tres")
static var material_red = preload("res://assets/3d/entities/gates/materials/gate_red.tres")

## Static vars
static var SCORE_BASE_MULTIPLIER = 100

## Local vars
var gate_done: bool = false
var gate_score: int = 0
@onready var gate_score_label = $gate_score


##
## Setup of the gate will be done here.
## Depending on the meta data the behavior
## will change
##
func _ready():
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(1, 10)

	if get_meta("is_positive"):
		$plane.material_override = material_blue
		gate_score = (SCORE_BASE_MULTIPLIER * random_number)
	else:
		$plane.material_override = material_red
		gate_score = -(SCORE_BASE_MULTIPLIER * random_number)

	gate_score_label.text = str(gate_score)


##
## If the player walks through the plane
##
func _on_area_3d_body_entered(body) -> void:
	if body is Player:
		if gate_done == false:
			gate_done = true
			gate_score_label.visible = false
			$plane.material_override = material_empty
			gate_activated.emit(gate_score)
