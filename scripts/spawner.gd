extends Node2D

onready var timer = $Timer
onready var container = get_parent()
onready var movingShape = load("res://scenes/movement.tscn") 

func _ready():
	timer.connect("timeout", self, "_every_sec")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false) # Make sure it loops
	timer.start()

func _every_sec():
	container.add_child(movingShape.instance())
