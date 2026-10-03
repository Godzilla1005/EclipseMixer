### Authored by Dawn2Dusk
### Abstract Class for list fields - contains information about file paths
@abstract class_name ListElement extends Control

## Class Nodes
@export var element_name: RichTextLabel

## Class Attributes
var file_name: String
var full_path: String

## Initializes information for this node
func setup(file: String, path: String):
	var label: String = file.get_file()
	
	file_name = file
	full_path = path
	name = file
	if element_name: 
		element_name.text = label
