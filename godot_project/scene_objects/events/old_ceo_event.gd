class_name old_ceo_event extends custom_event


func _init():
	title = "What do we do about the old CEO, CTO and CFO?"
	image_name = "old_ceo.png"
	description = """You just arrived to Twitter. The current CEO
is waiting for you, what should you do next?"""
	left_option = "Fire him immediately"
	right_option = "Humiliate him publicly, then ghosting him"


func check_condition(scene: Node) -> bool:
	var date = Time.get_date_dict_from_unix_time(scene.current_date)
	return date.year == 2022 and date.month == 10 and date.day == 28

func effect_left_option(scene) -> void:
	print("left")

func effect_right_option(scene) -> void:
	print("right")
