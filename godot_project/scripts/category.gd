@tool
extends VBoxContainer

signal take_action(metric)
signal hired_vp(action)
signal fired_vp(action)

@export var action_name : String
@export var vp_name : String
@export var metric_name : String
@export var default_quantity : int
@export var action_effect : int
@export var vp_frequency : int
@export var max_vips : int = 1
@export var can_quantity_be_negative : bool = false

@onready var quantity_label = $HBoxContainer/MetricQuantityLabel
@onready var vip_button = $VIPButton
@onready var progress = $Progress
@onready var enabled_timer = $EnabledTimer
@onready var vp_click = $VPClick
@onready var action_click = $actionClick
@onready var action_button = $ActionButton


var quantity : int:
	set(value):
		if not can_quantity_be_negative and value < 0:
			quantity = 0
		else:
			quantity = value
		quantity_label.text = str(quantity)

var vips : int = 0:
	set(value):
		if value < 0:
			vips = 0
		if value <= max_vips:
			vips = value
		if value >= max_vips:
			vips = max_vips
			vip_button.disabled = true
		vip_button.text = "Hire " + vp_name + " (" + str(vips) + ")"
		if vips > 0 and not progress.is_playing():
			progress.play("ongoing")
		elif vips == 0 and progress.is_playing():
			progress.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionButton.text = action_name
	$VIPButton.text = "Hire " + vp_name + " (" + str(vips) + ")"
	$HBoxContainer/MetricLabel.text = metric_name
	progress.speed_scale = vp_frequency / 10.0
	quantity = default_quantity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_action_button_pressed():
	action_click.play()
	take_effect()

func _on_vip_button_pressed():
	vp_click.play()
	vips += 1
	hired_vp.emit(self)

func fire_vp():
	vips = 0
	fired_vp.emit(self)
	vip_button.disabled = true
	enabled_timer.start()

func disable():
	vip_button.disabled = true
	action_button.disabled = true
	if vips > 0:
		fire_vp()
	enabled_timer.stop()
	progress.stop()

func take_effect():
	"""Increase the quantity when enabled manually or automatically"""
	quantity += action_effect
	take_action.emit(quantity)


func _on_enabled_timer_timeout():
	print("hiring for " + vp_name + " enabled")
	vip_button.disabled = false
