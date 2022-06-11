#!/usr/bin/env -S godot -s --no-window
extends SceneTree

func create_shape(shape_file):
    var path = "./scenes/%s" % shape_file
    var shape_name = shape_file.replace(".tscn","").replace("shape_", "Shape")

    var file = File.new()

    file.open(path, file.READ)
    var content = file.get_as_text().replace("name=\"RigidBody2D\"", "name=\"%s\"" % shape_name)
    file.close()

    file.open(path, file.WRITE)
    file.store_string(content)
    file.close()

# https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder?show=5176#a5176
func list_shape_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif "shape" in file:
            files.append(file)

    dir.list_dir_end()

    return files

func _init():
    var shapes = list_shape_in_directory("./scenes")
    for shape in shapes:
        create_shape(shape)
    quit()