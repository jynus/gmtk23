extends Node2D

@export var default_money : float = 44000000000
@export var default_users : int = 300000000
@export var default_brand : float = 100
@export var default_approval : float = 100
@export var default_date : int = Time.get_unix_time_from_datetime_dict({"year": 2022, "month": 10, "day": 27 })

var money_delta : float = -400000
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
@onready var event_screen = %event
@onready var game_over_screen = %game_over

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

var money : float:
	set(value):
		money = value
		money_label.metric = money

var users : int:
	set(value):
		if value < 0:
			users = 0
		else:
			users = value
		users_label.metric = users

var brand : float:
	set(value):
		if value < 0.0:
			brand = 0.0
		elif value > 100.0:
			brand = 100.0
		else:
			brand = value
		brand_label.metric = brand

var approval : float:
	set(value):
		if value < 0.0:
			approval = 0.0
		elif value > 100.0:
			approval = 100.0
		else:
			approval = value
		approval_label.metric = approval

@export var default_employees : int = 2300
@export var default_monthly_unique_visits : int = 10000000000
@export var default_advertisers : int = 100000000

var employees : int
var visits : int
var advertisers : int
var tokens : int
var assets : int
var angry_regulators : int = 0

var events : Array = []
var music_offset : float = 0
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
@onready var actions = $ScrollContainer/GridContainer.find_children("", "VBoxContainer", false)
var hired_vps : Array = []

func format_score(value : int) -> String:
	var score = str(value)
	var i : int = score.length() - 3
	while i > 0:
		score = score.insert(i, ",")
		i = i - 3
	return score

#########################################################
# ready function
#########################################################

func _ready():
	money = default_money
	users = default_users
	brand = default_brand
	approval = default_approval
	current_date = default_date
	employees = default_employees
	visits = default_monthly_unique_visits
	advertisers = default_advertisers
	firing.default_quantity = default_employees
	add_feature.default_quantity = default_monthly_unique_visits
	remove_feature.default_quantity = default_advertisers
	
	#setup events
	events = [
		old_ceo_event.new(),
		bankrupt.new(),
		no_users.new(),
		ruined_brand.new(),
		zero_approval.new(),
		money_sinkhole.new(),
		token_scam.new(),
		ousted_from_board.new(),
		eu_regulators.new(),
		everything_zero.new()
	]
	BackgroundMusic.play_song("game")
	rng.randomize()
	for action in actions:
		action.connect("hired_vp", hired_vp)


func hired_vp(action):
	hired_vps.append(action)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disable_tokens():
	%Crypto.disable()

func disable_investments():
	%Startup.disable()

func disable_terms():
	%Terms.disable()

func _on_timer_timeout():
	money += money_delta
	users += users_delta
	brand += brand_delta
	approval += approval_delta
	# next day
	current_date += 60 * 60 * 24
	var date = Time.get_date_dict_from_unix_time(current_date)
	
	# check for events
	for event in events:
		if (event.multiple_triggers or event.num_triggers == 0) and event.check_condition(self):
			show_event(event)
			return

func show_event(event):
	music_offset = BackgroundMusic.stop()
	BackgroundMusic.play_song("event")
	event_screen.title_text = event.title
	event_screen.image_name = event.image_name
	event_screen.description_text = event.description
	event_screen.left_button_text = event.left_option
	event_screen.right_button_text = event.right_option
	event_screen.show()
	event.num_triggers += 1
	get_tree().paused = true

	event_screen.connect("chose_option", func(option):
		if option == event_screen.left_button_text:
			event.effect_left_option(self)
		elif option == event_screen.right_button_text:
			event.effect_right_option(self)
		event_screen.hide()
		get_tree().paused = false
		BackgroundMusic.play_song("game", music_offset)
	)

func game_over():
	BackgroundMusic.play_song("gameover")
	var days : int = (current_date - default_date) / (3600 * 24)
	game_over_screen.show_game_over(days, money, users, brand, approval)
	game_over_screen.show()
	get_tree().paused = true

####################################
# logic for when buttons are pressed
####################################

func _on_firing_take_action(metric):
	var firings : int = max(0, employees - metric)
	employees = metric
	money -= 50000 * firings
	approval -= 0.005
	approval_delta -= 0.02 * firings
	var hired_vps_num : int = hired_vps.size()
	if  hired_vps_num > 0 and rng.randf() < (0.01 * hired_vps_num):
		print("fire_vp")
		show_event(fire_vp.new())

func _on_terms_take_action(metric):
	angry_regulators = metric
	money_delta += 1000
	brand_delta -= 0.01


func _on_crypto_take_action(metric):
	tokens = metric
	money -= 1000000
	money_delta -= 10000 * metric


func _on_add_feature_take_action(metric):
	var visits_lost : int = max(0, visits - metric)
	visits = metric
	money -= 1000 * visits_lost
	users += 100000


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
	assets = metric
	money -= 100000000
	approval -= 0.005
	brand_delta += 0.00002


func _on_paywall_take_action(metric):
	money += 100000
	money_delta += 10000
	users_delta -= 10000



func _on_poll_take_action(metric):
	users += 100000
	users_delta += 10000
	approval_delta -= 0.0005
	


func _on_promise_take_action(metric):
	users_delta -= 100000
	brand_delta -= 0.0005



func _on_dogwhistle_take_action(metric):
	users += 100
	users_delta -= 100000
	brand_delta -= 0.01
	money -= 1000000
	money_delta -= 100000
	approval -= 0.05
