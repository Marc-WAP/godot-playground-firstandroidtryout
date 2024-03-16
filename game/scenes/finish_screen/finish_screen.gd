extends Control

class_name FinishScreen

signal start_next_level()

@onready var label_score_level = $MarginContainer/GridContainer/label_level_score
@onready var label_score_total = $MarginContainer/GridContainer/label_total_score
@onready var label_score_high = $MarginContainer/GridContainer/label_high_score


func set_final_score(level :int, total :int, highscore :int) -> void:
	label_score_level.text = "Level score: {score}".format({"score": level})
	label_score_total.text = "Total score: {score}".format({"score": total})
	label_score_high.text = "High score: {score}".format({"score": highscore})


func _on_button_next_level_pressed():
	start_next_level.emit()
