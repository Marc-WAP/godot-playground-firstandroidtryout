extends Node3D

signal points_scored(points: int)
signal finish_activated()


# Called when the node enters the scene tree for the first time.
func _ready():
	for gate in $Gates.get_children():
		self._connect_gate(gate)

	var finish = $Finish
	if !(finish.finish_activated.is_connected(self._on_finish)):
		finish.finish_activated.connect(self._on_finish)


##
## Gate connector helper
##
func _connect_gate(gate):
	if !(gate.gate_activated.is_connected(self._on_gate_activated)):
		gate.gate_activated.connect(self._on_gate_activated)


##
## Slot for gate activations
##
func _on_gate_activated(points: int) -> void:
	points_scored.emit(points)

##
## Slot for Finishing
##
func _on_finish() -> void:
	finish_activated.emit()
