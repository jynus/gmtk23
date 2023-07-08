extends Node2D

@export var default_money : int = 44000000000
@export var default_users : int = 400000000

@onready var money_label = $GridContainer/Money
@onready var users_label = $GridContainer/Users
@onready var reputation_label = $GridContainer/Reputation
@onready var availability_label = $GridContainer/Availability

var money : int:
	set(value):
		money = value
		money_label.text = "Money:  $" + format_score(value)

var users : int:
	set(value):
		users = value
		users_label.text = "Users:  " + format_score(value)


func format_score(value : int) -> String:
	var score = str(value)
	var i : int = score.length() - 3
	while i > 0:
		score = score.insert(i, ",")
		i = i - 3
	return score

func _ready():
	money = default_money
	users = default_users


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_firing_take_action():
	money -= 50000


func _on_timer_timeout():
	money -= 400000
	users -= 3350
