extends Control

@onready var game_scores = %GameScores
@onready var high_scores = %HighScores

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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



func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
