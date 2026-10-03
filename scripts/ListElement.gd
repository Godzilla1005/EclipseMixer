class_name ListElement extends Control

## Class Nodes
@export var element_name: RichTextLabel

## Class Attributes
var file_name: String
var full_path: String

func setup(file: String, path: String):
	var label: String = file.get_file()
	
	file_name = file
	full_path = path
	name = file
	if element_name:
		element_name.text = label
