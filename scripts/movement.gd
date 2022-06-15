extends VisibilityNotifier2D
onready var rng = RandomNumberGenerator.new()

var vel: Vector2

func _ready():
	rng.randomize()
	var screen_size = get_viewport().get_visible_rect().size
	var from_x = rng.randf_range(0, screen_size.x)
	var from_y = rng.randf_range(0, screen_size.y)
	var to_x = rng.randf_range(0, screen_size.x)
	var to_y = rng.randf_range(0, screen_size.y)

	global_transform.origin = Vector2(from_x, from_y)
	vel = Vector2(to_x - from_x, to_y - from_y).normalized() * 100
	var scene = "res://scenes/shape_%s.tscn" % rng.randi_range(1,10)

	var shape = load(scene).instance()
	var shape_scale = 0.05 + rng.randf() * 0.15

	shape.scale.x = shape_scale
	shape.scale.y = shape_scale
	add_child(shape)

func _process(delta):
	translate(vel * delta)

func _on_Node2D_viewport_exited(_viewport):
	queue_free()
