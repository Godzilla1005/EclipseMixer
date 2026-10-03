extends Node2D

## connections
@export var importer: Importer
@export var import_list: ImportBuilder
@export var path: LineEdit
@export var volume: HSlider

## fields
var list: PackedStringArray

func _ready() -> void:
	AudioServer.set_bus_volume_linear(0, volume.value / 100)

## Attempt to import files
func _on_import_pressed() -> void:
	# reset list
	import_list.clear_list()
	
	# attempt to generate new import list
	list = importer.try_import(path.text)
	if list.size() > 0:
		import_list.create_list(list)

## Update the volume of the mixer
func volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value / 100)
