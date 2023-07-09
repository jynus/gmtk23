class_name ruined_brand extends custom_event

func _init():
	title = "Your reputation is in shambles"
	image_name = "old_ceo.png"
	description = """You are a joke as a CEO. Nobody trusts you or your business
	brand, and you are a living meme. What are you going to do about that?"""
	left_option = "I will keep meme-ing!"
	right_option = "I will show those who laugh!"

func check_condition(scene: Node) -> bool:
	return scene.brand <= 0.0001

func effect_left_option(scene) -> void:
	print("left")

func effect_right_option(scene) -> void:
	print("right")
