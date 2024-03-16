extends Resource
class_name SaveData

@export var high_score :int = 0

const SAVE_PATH :String = "user://highscore.tres"

func set_high_score(score :int) -> void:
	high_score = score
	self._save()


func _save() -> void:
	ResourceSaver.save(self, SAVE_PATH)


static func load_or_create() -> SaveData:
	var res :SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
	else:
		res = SaveData.new()
	return res
