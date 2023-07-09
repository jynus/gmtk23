class_name bankrupt extends custom_event

func _init():
	title = "No money, no problems"
	image_name = "bankrupt.png"
	description = """You have just ran out of money. For any other person,
	this would be a big problem, but you can just keep asking for a loan, right?"""
	left_option = "Of course!"
	right_option = "Why not?"

func check_condition(scene: Node) -> bool:
	return scene.money <= 0

func effect_left_option(scene) -> void:
	print("left")

func effect_right_option(scene) -> void:
	print("right")

