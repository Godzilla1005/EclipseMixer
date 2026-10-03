class_name PlaylistPreset extends Control

## Connections
@export var label: LineEdit
var playlist: Playlist
var importer: Importer

## Preset Fields
var files: PackedStringArray
var names: PackedStringArray
var playlist_name: String

## Create a new preset with the given list and path
func setup_list(new_list: PackedStringArray, passed_list: Playlist, passed_import: Importer, dir_path: String):
	playlist = passed_list
	importer = passed_import
	
	names = new_list
	label.text = dir_path
	for file in new_list:
		files.append(importer.path.path_join(file))

## Insert the saved playlist into the active playlist
func load_playlist():
	for i: int in range(files.size()):
		playlist.add_to_playlist(names[i], files[i])

## Deletes this preset
func delete_preset():
	queue_free()
