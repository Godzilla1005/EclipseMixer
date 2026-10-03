class_name Importer extends Node

@export var playlist_preset: PackedScene
@export var preset_list: Control
@export var playlist: Playlist

## import utils
var path: String = ""
var dir: DirAccess = null
var result: Error
var list: PackedStringArray
var imported_elements: Array[ImportElement]

## Opens the folder at the given path and attempts to access all the songs in the file
func try_import(_path: String) -> PackedStringArray:
	list = []
	
	## Check path
	if _path == null:
		push_warning("No path provided!")
		return list
	elif _path == "":
		push_warning("Path is empty!")
		return list
	
	## Try to open the directory
	path = _path
	dir = DirAccess.open(path)
	result = DirAccess.get_open_error()
	if result != OK:
		push_warning("Failed to open directory! Error Code ", result)
		return list
	
	var directories := dir.get_directories()
	if directories.size() > 0:
		for lists in dir.get_directories():
			find_playlists(lists)
	
	## Read every song in the import directory
	list.append_array(dir.get_files())
	
	if list.size() <= 0:
		push_warning("No files found!")
	
	list = filter_list(list)
	print_files()
	
	return list


func find_playlists(dir_path: String):
	var list_dir: DirAccess = DirAccess.open(path.path_join(dir_path))
	var new_preset: PlaylistPreset = playlist_preset.instantiate()
	var temp_array: PackedStringArray
	
	for file in list_dir.get_files():
		if file.get_extension() == "mp3":
			temp_array.append(dir_path.path_join(file))
	if temp_array.size() <= 0: return
	
	list.append_array(temp_array)
	
	preset_list.add_child(new_preset)
	new_preset.setup_list(temp_array, playlist, self, dir_path)

## Filters the file list to remove all elements that are not .mp3's
func filter_list(input: PackedStringArray) -> PackedStringArray:
	var new_list: PackedStringArray
	
	## Check every file and add it to the new list if it is an mp3
	for file: String in input:
		if (file.get_extension() == "mp3"):
			new_list.append(file)
	
	return new_list

## Reads out all of the found files
func print_files():
	print("File list:")
	for file: String in list:
		print(file)

## Loops through all the stored files and creates import elements for each
func create_elements():
	return
