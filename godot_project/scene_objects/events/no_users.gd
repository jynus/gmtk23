class_name no_users extends custom_event

func _init():
	title = "Your website has no active users"
	image_name = "old_ceo.png"
	description = """Thanks to your efforts, users have long abandoned your
	website for better alternatives. There is almost 0 users around, remembering
	the good old days. Congratulations, you played yourself"""
	left_option = "The less the merrier"
	right_option = "They will come back as soon as they realize the other places are worse"

func check_condition(scene: Node) -> bool:
	return scene.users <= 1000

func effect_left_option(scene) -> void:
	print("left")

func effect_right_option(scene) -> void:
	print("right")

