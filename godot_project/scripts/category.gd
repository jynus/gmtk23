@tool
extends VBoxContainer

signal take_action(metric)

@export var action_name : String
@export var vp_name : String
@export var metric_name : String
@export var default_quantity : int
@export var action_effect : int
@export var vp_frequency : int
@export var max_vips : int = 1

@onready var quantity_label = $HBoxContainer/MetricQuantityLabel
@onready var timer = $Timer
@onready var vip_button = $VIPButton


var quantity : int:
	set(value):
		quantity = value
		quantity_label.text = str(quantity)

var vips : int = 0:
	set(value):
		if value <= max_vips:
			vips = value
		if value >= max_vips:
			vips = max_vips
			vip_button.disabled = true
		vip_button.text = "Hire " + vp_name + " (" + str(vips) + ")"
		if vips > 0 and timer.is_stopped():
			timer.start()
		elif vips == 0 and not timer.is_stopped():
			timer.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionButton.text = action_name
	$VIPButton.text = "Hire " + vp_name + " (" + str(vips) + ")"
	$HBoxContainer/MetricLabel.text = metric_name
	timer.wait_time = vp_frequency
	quantity = default_quantity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_action_button_pressed():
	take_effect()

func _on_vip_button_pressed():
	vips += 1

func _on_timer_timeout():
	take_effect()

func take_effect():
	"""Increase the quantity when enabled manually or automatically"""
	quantity += action_effect
	take_action.emit(quantity)
