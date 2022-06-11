extends Node2D

var cover = false;

func _process(delta):
	if not cover:
		delta = -delta
	$TextureProgress.value += delta * 100

	if $TextureProgress.value < 0:
		$TextureProgress.value = 0

func _on_Area2D_body_entered(body):
	cover = true

func _on_Area2D_body_exited(body):
	cover = false
