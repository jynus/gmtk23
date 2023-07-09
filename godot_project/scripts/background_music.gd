extends Node

@onready var music_player : AudioStreamPlayer = %musicPlayer
var playlist : Dictionary = {
	"menu": preload("res://assets/music/ES_Deep Down Diamond Alley - Josef Bel Habib.mp3"),
	"pause": preload("res://assets/music/ES_A Heart Made of Pixels - Christoffer Moe Ditlevsen.mp3"),
	"game": preload("res://assets/music/ES_Play Me Like That Video Game - Josef Bel Habib.mp3"),
	"event": preload("res://assets/music/ES_Time to Level Up - Josef Bel Habib.mp3"),
	"gameover": preload("res://assets/music/ES_Back to Business - William Benckert.mp3")
}
var _current_song : String
@export var current_song : String :
	set (value):
		_set_current_song(value)
	get:
		return _current_song

func _set_current_song(value):
	_current_song = value
	music_player.stream = playlist[current_song]

func _ready():
	music_player.volume_db = -10

func _process(_delta):
	pass

func play_song(screen: String, offset : float = 0.0):
	if screen not in playlist.keys() or current_song == screen:
		return
	stop()
	current_song = screen
	music_player.play(offset)

func stop() -> float:
	var pos : float = music_player.get_playback_position()
	if music_player.playing:
		music_player.stop()
	return pos

