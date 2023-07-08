extends Node2D

@export var default_money : int = 44000000000
@export var default_users : int = 400000000
@export var default_brand : float = 100
@export var default_approval : float = 100

var money_delta : int = -400000
var users_delta : int = -20000
var brand_delta : float = 0
var approval_delta : float = 0

@onready var money_label = %Money
@onready var users_label = %Users
@onready var brand_label = %Brand
@onready var approval_label = %Approval
@onready var date_label = %DateLabel
@onready var firing = %Firing
@onready var add_feature = %AddFeature
@onready var remove_feature = %RemoveFeature
@onready var event = %event

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
		money_label.text = "Money:    $" + format_score(money)

var users : int:
	set(value):
		if value < 0:
			users = 0
		else:
			users = value
		users_label.text = "Users:      " + format_score(users)

var brand : float:
	set(value):
		if value < 0.0:
			brand = 0.0
		elif value > 100.0:
			brand = 100.0
		else:
			brand = value
		brand_label.text = "Brand  value:  " + str(brand).pad_decimals(2) + "%"

var approval : float:
	set(value):
		if value < 0.0:
			approval = 0.0
		elif value > 100.0:
			approval = 100.0
		else:
			approval = value
		approval_label.text = "Empl.  approval:  " + str(approval).pad_decimals(2) + "%"

@export var default_employees : int = 2300
@export var default_monthly_unique_visits : int = 10000000000
@export var default_advertisers : int = 100000000

var employees : int
var visits : int
var advertisers : int

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
	visits = default_monthly_unique_visits
	advertisers = default_advertisers
	firing.default_quantity = default_employees
	add_feature.default_quantity = default_monthly_unique_visits
	remove_feature.default_quantity = default_advertisers
	

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
	var date = Time.get_date_dict_from_unix_time(current_date)
	if date.year == 2022 and date.month == 10 and date.day == 28:
		old_CEO_firing_event()


func old_CEO_firing_event():
	event.title_text = "What do we do about the old CEO?"
	event.image_name = "old_ceo.png"
	event.description_text = """You just arrive to Twitter. The current CEO
	is waiting for you, what should you do next?"""
	event.left_button_text = "Fire him immediately"
	event.right_button_text = "Humiliate him publicly, then ghosting him"
	event.show()
	get_tree().paused = true

	event.connect("chose_option", func(option):
		if option == event.left_button_text:
			print("left")
		else:
			print("right")
		event.hide()
		get_tree().paused = false
	)

####################################
# logic for when buttons are pressed
####################################

func _on_firing_take_action(metric):
	var firings : int = max(0, employees - metric)
	employees -= metric
	money -= 50000 * firings
	approval -= 0.03
	approval_delta -= 0.02 * firings

func _on_terms_take_action(metric):
	money_delta -= 1000000
	brand_delta -= 0.01


func _on_crypto_take_action(metric):
	money -= 1000000
	money_delta -= 10000 * metric


func _on_add_feature_take_action(metric):
	var visits_lost : int = max(0, visits - metric)
	visits = metric
	money -= 1000 * visits_lost
	users += 10000


func _on_pr_stunt_take_action(metric):
	users += 10000
	brand_delta -= 0.00001

func _on_remove_feature_take_action(metric):
	var advertisers_lost : int = max(0, advertisers - metric)
	users -= 1000000
	users_delta += 10000
	money_delta -= round(advertisers_lost / 10000.0)


func _on_public_statement_take_action(metric):
	users -= 10000
	brand_delta -= 0.00001


func _on_startup_take_action(metric):
	money -= 100000000
	approval -= 0.005
	brand_delta += 0.00002


func _on_paywall_take_action(metric):
	money += 100000
	money_delta += 10000
	users_delta -= 100000



func _on_poll_take_action(metric):
	users += 100000
	users_delta += 10000
	approval_delta -= 0.0005
	


func _on_promise_take_action(metric):
	users_delta -= 100000
	brand_delta -= 0.0005



func _on_dogwhistle_take_action(metric):
	users += 1000
	users_delta -= 100000
	brand_delta -= 0.005
	money -= 1000000
	money_delta -= 100000
	approval -= 0.05
