### Authored by Dawn2Dusk
### Class that handles the main scene
extends Node2D

## Connections
@export var importer: Importer
@export var import_list: ImportBuilder
@export var path: LineEdit
@export var volume: HSlider
@export var preset_list: VBoxContainer
@export var playlist_list: PlaylistBuilder

## Fields
var list: PackedStringArray

## Initialize the volume
func _ready() -> void:
	AudioServer.set_bus_volume_linear(0, volume.value / 100)

## Attempt to import files
func _on_import_pressed() -> void:
	## reset lists
	import_list.clear_list()
	playlist_list.clear_list()
	for child in preset_list.get_children():
		child.queue_free()
	
	## attempt to generate new import list
	list = importer.try_import(path.text)
	if list.size() > 0:
		import_list.create_list(list)

## Update the volume of the main bus
func volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value / 100)
