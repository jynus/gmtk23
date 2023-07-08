extends Control

signal chose_option(text)

@onready var title = %title
@onready var image = %image
@onready var description = %description
@onready var left_text = %left_text
@onready var right_text = %right_text


@export var title_text : String = "":
	set(value):
		title_text = value
		if title != null:
			title.text = title_text

@export var image_name : String = "":
	set(value):
		if value != null:
			image_name = value
			if image_name != "" and title != null:
				image.texture = load("res://assets/sprites/" + image_name)


@export var description_text : String = "":
	set(value):
		description_text = value
		if description != null:
			description.text = "[center]" + description_text + "[/center]"

@export var left_button_text : String = "":
	set(value):
		left_button_text = value
		if left_text != null:
			left_text.text = "[left]" + left_button_text + "[/left]"

@export var right_button_text : String = "":
	set(value):
		right_button_text = value
		if right_text != null:
			right_text.text = "[right]" + right_button_text + "[/right]"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_button_pressed():
	chose_option.emit(left_button_text)


func _on_right_button_pressed():
	chose_option.emit(right_button_text)
