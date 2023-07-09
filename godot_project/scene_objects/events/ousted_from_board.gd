class_name ousted_from_board extends custom_event

func _init():
	title = "You were expelled from the board of directors in your investments"
	image_name = "ousted_board.png"
	description = """The US Securities Commision has banned you from being in the board of directors of any startup for a harmless joke you did.
	You won't be able to continue investing and will lose your participation in ClosedAI, Tensla and Space Y"""
	left_option = "Chirp '420 69 LOL' ([color=red]Can't invest & lose brand[/color])"
	right_option = "Find an intermediary ([color=red]Can't invest & lose money[/color])"

func check_condition(scene: Node) -> bool:
	return scene.assets >= 10000000

func effect_left_option(scene) -> void:
	scene.disable_investments()
	scene.brand -= 0.5

func effect_right_option(scene) -> void:
	scene.disable_investments()
	scene.money -= 1000000000
