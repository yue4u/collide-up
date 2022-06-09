#!/usr/bin/env -S godot -s --no-window
extends SceneTree

func create_shape(png: String):
    var path = "./shapes/%s.tscn" % png.replace(".png","")

    var text = PoolStringArray([
        "[gd_scene load_steps=2 format=2]", #
        "[ext_resource path=\"res://assets/gradient-fluid-frame/" +  png + "\" type=\"Texture\" id=1]",
        "[node name=\"RigidBody2D\" type=\"RigidBody2D\"]",
        "[node name=\"Sprite\" type=\"Sprite\" parent=\".\"]",
        "texture = ExtResource( 1 )"
    ]).join("\n\n")

    var file = File.new()
    file.open(path, file.WRITE)
    file.store_string(text)
    file.close()

# https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder?show=5176#a5176
func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif file.ends_with(".png"):
            files.append(file)

    dir.list_dir_end()

    return files

func _init():
    var pngs = list_files_in_directory("./assets/gradient-fluid-frame")
    for png in pngs:
        create_shape(png)
    quit()