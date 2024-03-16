extends Node3D


# Global scene instances
@onready var finish_screen = $FinishScreen
@onready var ui = $MainUi
@onready var player = $Player
@onready var player_start_point = $PlayerStartPoint.global_position
@onready var level_manager = $LevelManager

# Game state variables
var next_level_requested :bool = false
var save_data :SaveData
var level_score :int = 0 :
	set (value):
		level_score = value
		ui.set_score(level_score)
	get:
		return level_score
var game_score :int = 0 :
	set (value):
		game_score = value
		if game_score > save_data.high_score:
			save_data.set_high_score(game_score)
	get:
		return game_score


# Called when the node enters the scene tree for the first time.
func _ready():
	save_data = SaveData.load_or_create()
	ui.set_score(0)
	if !(level_manager.points_scored.is_connected(self._on_points_scored)):
		level_manager.points_scored.connect(self._on_points_scored)

	if !(level_manager.finish_activated.is_connected(self._on_finish)):
		level_manager.finish_activated.connect(self._on_finish)

	if !(finish_screen.start_next_level.is_connected(self._on_start_next_level)):
		finish_screen.start_next_level.connect(self._on_start_next_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if next_level_requested:
		next_level_requested = false
		_start_next_level()


func _on_points_scored(points: int) -> void:
	level_score += points


func _on_finish() -> void:
	game_score += level_score
	finish_screen.set_final_score(level_score, game_score, save_data.high_score)
	self._toggle_ui()


func _on_start_next_level() -> void:
	next_level_requested = true


func _start_next_level():
	level_score = 0
	level_manager.start_next_level()
	player.global_position = player_start_point
	self._toggle_ui()


func _toggle_ui() -> void:
	ui.visible = !ui.visible
	finish_screen.visible = !finish_screen.visible
