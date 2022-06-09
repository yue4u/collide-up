extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	vel = vel.normalized()
	vel *= 300
	set_linear_velocity(vel)
