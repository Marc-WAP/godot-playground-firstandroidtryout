extends Control

@onready var label_score = $MainMarginContainer/MarginContainer/LabelScore
@onready var main_margin_container = $MainMarginContainer


func _ready():
	var safe = DisplayServer.get_display_safe_area()
	if safe.position.y > 0:
		main_margin_container.add_theme_constant_override("margin_top", safe.position.y)


##
## Slot for updating the score
##
func set_score(points: int) -> void:
	label_score.text = "Score: {score}".format({"score": points})
