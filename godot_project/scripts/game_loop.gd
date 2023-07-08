extends Node2D

@export var default_money : int = 44000000000
@export var default_users : int = 400000000
@export var default_brand : float = 100
@export var default_approval : float = 100

var money_delta : int = -400000
var users_delta : int = -10000
var brand_delta : float = 0
var approval_delta : float = 0

@onready var money_label = %Money
@onready var users_label = %Users
@onready var brand_label = %Brand
@onready var approval_label = %Approval
@onready var date_label = %DateLabel
@onready var firing = %Firing

var months : Array = [
	"",
	"Jan",
	"Feb",
	"Mar",
	"Apr",
	"May",
	"Jun",
	"Jul",
	"Aug",
	"Sep",
	"Oct",
	"Nov",
	"Dec"
]

var current_date : int:
	set(value):
		current_date = value
		var date = Time.get_date_dict_from_unix_time(current_date)
		date_label.text = months[date["month"]] + "\n" + str(date["day"]) + "\n" + str(date["year"])

var money : int:
	set(value):
		money = value
		money_label.text = "Money:    $" + format_score(value)

var users : int:
	set(value):
		users = value
		users_label.text = "Users:      " + format_score(value)


var brand : float:
	set(value):
		brand = value
		brand_label.text = "Brand  value:  " + str(value).pad_decimals(2) + "%"

var approval : float:
	set(value):
		approval = value
		approval_label.text = "Empl.  approval:  " + str(value).pad_decimals(2) + "%"

@export var default_employees : int = 2300

var employees : int

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
	brand = default_brand
	approval = default_approval
	current_date = Time.get_unix_time_from_datetime_dict({"year": 2022, "month": 10, "day": 27 })
	employees = default_employees
	firing.default_quantity = default_employees
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	money += money_delta
	users += users_delta
	brand += brand_delta
	approval += approval_delta
	# next day
	current_date += 60 * 60 * 24

####################################
# logic for when buttons are pressed
####################################

func _on_firing_take_action(metric):
	var firings : int = max(0, employees - metric)
	employees -= metric
	money += 50000 * firings
	approval_delta -= 0.005 * firings

func _on_terms_take_action(metric):
	money_delta -= 1000000
	brand_delta -= 0.01
