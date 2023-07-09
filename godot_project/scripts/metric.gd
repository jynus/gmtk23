extends HBoxContainer

@onready var arrow : AnimatedSprite2D = $arrow
@onready var label = $Metric

@export var metric_name : String
@export var decimals : int = 2
enum available_types {DOLLAR, PERCENTAGE, NUMBER}
@export var type : available_types
@export var metric : float:
	set(value):
		if value > metric and arrow != null:
			arrow.play("up")
		elif value < metric and arrow != null:
			arrow.play("down")
		elif arrow != null:
			arrow.play("equal")
		metric = value
		if label != null:
			label.text = metric_name + " " + format_score(metric)

func format_score(value : float) -> String:
	if type == available_types.PERCENTAGE:
		return str(value).pad_decimals(2) + "%"
	var split_string = str(value).split(",")
	var score = split_string[0]
	var i : int = score.length() - 3
	while i > 0:
		score = score.insert(i, ",")
		i = i - 3
	if split_string.size() > 1:
		score += '.' + '.'.join(split_string.slice(1))
	if type == available_types.DOLLAR:
		score = "$" + score
	return score
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
