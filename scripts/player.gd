extends KinematicBody2D

var Goal = load("res://scripts/goal.gd")

var pause = false;

func _physics_process(_delta):
	if pause:
		return

	var vel = Vector2()
	if Input.is_key_pressed(KEY_D):
		vel.x += 1
	if Input.is_key_pressed(KEY_A):
		vel.x += -1
	if Input.is_key_pressed(KEY_W):
		vel.y += -1
	if Input.is_key_pressed(KEY_S):
		vel.y += 1
	var __ = move_and_slide(vel.normalized() * 300, Vector2(2, 0), false, 4, 0.785, true)

func _on_Area2D_area_entered(area):
	if area is Goal:
		area.cover = true
		return
	if area.name == "Danger":
		var __ = get_tree().reload_current_scene()
		return
	transfer(area.get_node("CollisionPolygon2D"), $Area2D)
	transfer(area.get_node("Sprite"), self)

func _on_Area2D_area_exited(area):
	if area is Goal:
		area.cover = false
		return

func transfer(n1, n2):
	if not n1 or n1.get_parent() == n2:
		return
	var n1_pos = n1.global_transform
	n1.get_parent().remove_child(n1)
	n2.add_child(n1, true)
	n1.global_transform = n1_pos
	n1.set_owner(n2)
