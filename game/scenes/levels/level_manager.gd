extends Node

##
## Signals from the levels
##
signal points_scored(points: int)
signal finish_activated()

##
## Scene elements
##
@onready var level_holder = $LevelHolder

##
## local vars
##
const path_level_1 = "res://scenes/levels/level_01/level_01.tscn"
const path_level_2 = "res://scenes/levels/level_02/level_02.tscn"

enum levels {
	LEVEL01,
	LEVEL02,
	ALL_DONE
}
var current_level = levels.LEVEL01


# Called when the node enters the scene tree for the first time.
func _ready():
	load_level()


func load_level():
	var level = null

	# Select the new next level
	match current_level:
		levels.LEVEL01:
			level = load(path_level_1).instantiate()
		levels.LEVEL02:
			level = load(path_level_2).instantiate()

	# Remove the old level (if present)
	if level_holder.get_child_count():
		for elem in level_holder.get_children():
			elem.call_deferred("queue_free")

	# Connect signal for scoring points
	if !(level.points_scored.is_connected(self._on_points_scored)):
		level.points_scored.connect(self._on_points_scored)

	# Connect signal for finishing
	if !(level.finish_activated.is_connected(self._on_finish)):
		level.finish_activated.connect(self._on_finish)

	# Place the level
	level_holder.add_child(level)


func start_next_level() -> void:
	var level = current_level + 1
	if level == levels.ALL_DONE:
		level = levels.LEVEL01

	@warning_ignore("INT_AS_ENUM_WITHOUT_CAST")
	current_level = level
	self.load_level()


##
## Slot for whenever the player
##   SCORES some points
##
func _on_points_scored(points: int) -> void:
	points_scored.emit(points)


##
## Slot for whenever the player
##   FINISHES by walking throuhg
##   the finish line
##
func _on_finish() -> void:
	finish_activated.emit()
