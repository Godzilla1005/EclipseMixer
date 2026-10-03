### Authored by Dawn2Dusk
### Base class for preset nodes
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
	## save new connections
	playlist = passed_list
	importer = passed_import
	
	## set up preset
	names = new_list
	label.text = dir_path
	for file in new_list:
		## save complete path for each file
		files.append(importer.path.path_join(file))

## Insert the saved playlist into the active playlist
func load_playlist():
	for i: int in range(files.size()):
		playlist.add_to_playlist(names[i], files[i])

## Deletes this preset
func delete_preset():
	queue_free()
