extends Control

@onready var game_scores = %GameScores
@onready var high_scores = %HighScores

var SETTINGS_FILE_PATH : String = "user://highscores.cfg"
var _configFile : ConfigFile
var highscore_days : int
var highscore_money : float
var highscore_users : int
var highscore_brand : float
var highscore_approval : float

# Called when the node enters the scene tree for the first time.
func _ready():
	_configFile = ConfigFile.new()
	var err = _configFile.load(SETTINGS_FILE_PATH)
	if err != OK: 
		print("Error while loading highscore file: " + str(err))
	# apply settings
	highscore_days = _configFile.get_value("highscore", "days", 365)
	highscore_money = _configFile.get_value("highscore", "money", 0)
	highscore_users = _configFile.get_value("highscore", "users", 230000000)
	highscore_brand = _configFile.get_value("highscore", "brand", 100)
	highscore_approval = _configFile.get_value("highscore", "approval", 100)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_game_over(days, money, users, brand, approval):
	game_scores.text = """[center][u]YOUR SCORE[/u]
%d
%d
%d
%f %%
%f %%[/center]""" % [days, money, users, brand, approval]

	if days < highscore_days:
		highscore_days = days
		_configFile.set_value("highscore", "days", highscore_days)
	if money < highscore_money:
		highscore_money = money
		_configFile.set_value("highscore", "money", highscore_money)
	if users < highscore_users:
		highscore_users = users
		_configFile.set_value("highscore", "users", highscore_users)
	if brand < highscore_brand:
		highscore_brand = brand
		_configFile.set_value("highscore", "brand", highscore_brand)
	if approval < highscore_approval:
		highscore_approval = approval
		_configFile.set_value("highscore", "approval", highscore_approval)
	
	high_scores.text = """[center][u]YOUR SCORE[/u]
%d
%d
%d
%f %%
%f %%[/center]""" % [highscore_days, highscore_money, highscore_users, highscore_brand, highscore_approval]

	_configFile.save(SETTINGS_FILE_PATH)


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
