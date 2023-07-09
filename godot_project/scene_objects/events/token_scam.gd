class_name token_scam extends custom_event

func _init():
	title = "The crypto you bought was a scam"
	image_name = "crypto_scam.png"
	description = """You just learned that the coin you were buying was a scam, and the people run with your money.
	You no longer have any tokens and all the money was lost"""
	left_option = "Sweep it under the rug ([color=red]You lose the ability to buy tokens & money[/color])"
	right_option = "Denounce the token publicly ([color=red]You lose the ability to buy tokens & brand[/color])"

func check_condition(scene: Node) -> bool:
	return scene.tokens >= 500

func effect_left_option(scene) -> void:
	scene.disable_tokens()
	scene.money -= 500000000

func effect_right_option(scene) -> void:
	scene.disable_tokens()
	scene.brand -= 0.5
