class_name money_sinkhole extends custom_event

func _init():
	title = "You lost more than 1 trillion dollars"
	image_name = "money_sinkhole.png"
	description = """Even for you, losing 1 trillion dollars is too much money!
	Your management led to the website being a mony sinkhole, and you lenders
	are not happy. It is time to say goodby to playing CEO. The business will
	be liquidated and its pending assets shared among debtors. This is the
	en of your career (bad ending).
	"""
	left_option = "Nooooooooooooooo."
	right_option = "They could never understand a genius like me."

func check_condition(scene: Node) -> bool:
	return scene.money <= -1000000000000

func effect_left_option(scene) -> void:
	scene.game_over()

func effect_right_option(scene) -> void:
	scene.game_over()

