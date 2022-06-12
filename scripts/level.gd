extends Node

onready var scene_name = get_tree().get_current_scene().get_name()
onready var level_label = $UI/MarginContainer/HBoxContainer/Level

onready var goals = $Goals.get_children()
onready var goals_label = $UI/MarginContainer/HBoxContainer/HBoxContainer/Goals
onready var all = goals.size();

onready var time_label = $UI/MarginContainer/HBoxContainer/Time;
onready var timer = $UI/MarginContainer/HBoxContainer/Time/Timer
onready var result = $UI/Result

var clear = false
var time = 0

func _ready():
	print("%s is ready" % scene_name)
	level_label.text = scene_name

	get_tree().paused = false

	timer.connect("timeout", self, "_every_sec")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false) # Make sure it loops
	timer.start()

func _process(_delta):
	if clear:
		if Input.is_key_pressed(KEY_SPACE):
			load_next()
		return

	# give me reduce...
	var done = 0
	for i in all:
		var goal = goals[i]
		if goal.is_covered():
			done +=1
	goals_label.text = "{done} / {all}".format({ "done": done, "all": all})

	if done != all:
		return
	clear = true
	result.visible = true

func load_next():
	var next_level = int(scene_name) + 1
	var __ = get_tree().change_scene("res://levels/level_%s.tscn" % next_level)

func _every_sec():
	time +=1
	var _min = int(time / 60)
	var _sec = time % 60
	time_label.text = "%02d : %02d" % [_min, _sec]

