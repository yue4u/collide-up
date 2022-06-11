extends Node2D

var cover = false;

func _process(delta):
	if not cover:
		delta = -delta
	$TextureProgress.value += delta * 100

	if $TextureProgress.value < 0:
		$TextureProgress.value = 0

func _on_entered():
	cover = true

func _on_exited():
	cover = false

func is_covered():
	return $TextureProgress.value == 100
