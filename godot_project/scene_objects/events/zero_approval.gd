class_name zero_approval extends custom_event

func _init():
	title = "Your employees have no respect towards you"
	image_name = "old_ceo.png"
	description = """In the last survey, almost no exployee belives in the vision
	you set for the business. They all think you are a joke and don't take your
	job seriously. What are you going to do about that?"""
	left_option = "I will find better employees elsewhere"
	right_option = "That's actually good, the less happy employees are, the more productive they are"

func check_condition(scene: Node) -> bool:
	return scene.approval <= 0.0001

func effect_left_option(scene) -> void:
	print("left")

func effect_right_option(scene) -> void:
	print("right")

