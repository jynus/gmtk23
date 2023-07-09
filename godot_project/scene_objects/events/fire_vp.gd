class_name fire_vp extends custom_event


func _init():
	title = "Accidentally fired a VP"
	image_name = "old_ceo.png"
	description = """While firing a bunch of people, you just realize that
you fired a VP, which helped you managing things automatically. It will take
some time before you can hire a replacement"""
	left_option = "Good"
	right_option = "Nobody is essential"


func check_condition(scene: Node) -> bool:
	return false


func fire_random_vp(scene):
	if scene.hired_vps.size() == 0:
		return
	scene.hired_vps.shuffle()
	scene.hired_vps.pop_front().fire_vp()
	

func effect_left_option(scene) -> void:
	fire_random_vp(scene)

func effect_right_option(scene) -> void:
	fire_random_vp(scene)
