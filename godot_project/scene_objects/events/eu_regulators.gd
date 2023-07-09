class_name eu_regulators extends custom_event

func _init():
	title = "The EU regulators are done investigating Chirper"
	image_name = "eu_regulators.png"
	description = """The European Commission was investigating you for not meeting the user privacy minimums, nor having enough people handling Trust & Safety concerns.
	They fine you 2 billion dollars."""
	left_option = "Pay ([color=red]Can't change terms & lose money[/color])"
	right_option = "Block EU users ([color=red]Can't change terms & lose users[/color])"

func check_condition(scene: Node) -> bool:
	print(scene.default_employees, scene.employees)
	return scene.angry_regulators >= 100 and (scene.default_employees - scene.employees) > 300

func effect_left_option(scene) -> void:
	scene.disable_terms()
	scene.money -= 2000000000

func effect_right_option(scene) -> void:
	scene.disable_terms()
	scene.users -= scene.users / 3

