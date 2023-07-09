class_name custom_event extends Object

@export var title: String
@export var image_name : String
@export var description : String
@export var left_option : String
@export var right_option : String
@export var multiple_triggers : bool = false
@export var num_triggers : int = 0

func check_condition(scene: Node) -> bool:
	return false

func effect_left_option(scene: Node) -> void:
	pass

func effect_right_option(scene: Node) -> void:
	pass
