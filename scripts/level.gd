extends Node

onready var scene_name = get_tree().get_current_scene().get_name()
onready var level_label = $UI/MarginContainer/HBoxContainer/Level

onready var goals = $Goals.get_children()
onready var goals_label = $UI/MarginContainer/HBoxContainer/HBoxContainer/Goals
onready var all = goals.size();

var clear = false

func _ready():
	print("%s is ready" % scene_name)
	get_tree().paused = false
	level_label.text = scene_name

func _process(_delta):
	# give me reduce...
	var done = 0
	for i in all:
		var goal = goals[i]
		if goal.is_covered():
			done +=1
	goals_label.text = "{done} / {all}".format({ "done": done, "all": all})

	if done != all:
		return

	get_tree().paused = true
	load_next()

func load_next():
	yield(get_tree().create_timer(1.0), "timeout")
	var next_level = int(scene_name) + 1
	var __ = get_tree().change_scene("res://levels/level_%s.tscn" % next_level)

