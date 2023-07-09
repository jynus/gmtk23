extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundMusic.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		load_gameplay()

func load_gameplay():
	get_tree().change_scene_to_file("res://scenes/game_loop.tscn")
