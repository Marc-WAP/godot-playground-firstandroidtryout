extends Node3D

@onready var level_label = $LevelLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_number = get_meta("level_number")
	level_label.text = "Level {level}".format({"level": str(level_number)}) 
