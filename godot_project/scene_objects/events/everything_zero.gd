class_name everything_zero extends custom_event

func _init():
	title = "You made it"
	image_name = "old_ceo.png"
	description = """You were able to not only bankrupt your business, but also drive all users, advertisers and employees away.
	The Chirper brand is now worth nothing, outages happen daily and the only active users a few nazis that stick around."""
	left_option = "Just as I planned ([color=red]Game over[/color])"
	right_option = "The important thing is freedom of speech ([color=red]Game over[/color])"

func check_condition(scene: Node) -> bool:
	return scene.money <= 0 and scene.users <= 10000 and scene.brand <= 0.1 and scene.approval <= 0.1

func effect_left_option(scene) -> void:
	scene.game_over()

func effect_right_option(scene) -> void:
	scene.game_over()
