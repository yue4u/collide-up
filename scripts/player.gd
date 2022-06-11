extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
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


func _on_Area2D_body_entered(body):
	transfer(body.get_node("CollisionPolygon2D"), $Area2D)
	transfer(body.get_node("Sprite"), self)

func transfer(n1, n2):
	if not n1 or n1.get_parent() == n2:
		return
	var n1_pos = n1.global_transform
	n1.get_parent().remove_child(n1)
	n2.add_child(n1, true)
	n1.global_transform = n1_pos
	n1.set_owner(n2)
