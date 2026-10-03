### Authored by Dawn2Dusk
### Class that handles the initial import and reading of the priamry directory
class_name Importer extends Node

## Connections
@export var playlist_preset: PackedScene
@export var preset_list: Control
@export var playlist: Playlist

## Import Utils
var path: String = ""
var dir: DirAccess = null
var result: Error
var list: PackedStringArray
var imported_elements: Array[ImportElement]

## Opens the folder at the given path and attempts to access all the songs in the file
func try_import(_path: String) -> PackedStringArray:
	list = []
	
	## check path
	if _path == null:
		push_warning("No path provided!")
		return list # path not found
	elif _path == "":
		push_warning("Path is empty!")
		return list # path not found
	
	## try to open the directory
	path = _path
	dir = DirAccess.open(path)
	result = DirAccess.get_open_error()
	if result != OK:
		push_warning("Failed to open directory! Error Code ", result)
		return list # directory failed to open
	
	## attempt to access subfolder
	var directories := dir.get_directories()
	if directories.size() > 0:
		## check every subfolder for audio files
		for lists in dir.get_directories():
			find_playlists(lists)
	
	## read every song in the import directory
	list.append_array(dir.get_files())
	
	if list.size() <= 0:
		push_warning("No files found!")
		return list # no files found
	
	list = filter_list(list)
	print_files() # debug
	return list # success

## Read subfolders to find additional files
func find_playlists(dir_path: String):
	## local search variables
	var list_dir: DirAccess = DirAccess.open(path.path_join(dir_path))
	var new_preset: PlaylistPreset = playlist_preset.instantiate()
	var temp_array: PackedStringArray
	
	## check every file in the given folder to find MP3's
	for file in list_dir.get_files():
		if file.get_extension() == "mp3":
			## save the audio file with additional path information
			temp_array.append(dir_path.path_join(file))
	if temp_array.size() <= 0:
		return # failed to find more audio files
	
	## store the found files in the main list
	list.append_array(temp_array)
	
	## create a new preset with the found files
	preset_list.add_child(new_preset)
	new_preset.setup_list(temp_array, playlist, self, dir_path)

## Filters the file list to remove all elements that are not .mp3's
func filter_list(input: PackedStringArray) -> PackedStringArray:
	var new_list: PackedStringArray
	
	## check every file and add it to the new list if it is an mp3
	for file: String in input:
		if (file.get_extension() == "mp3"):
			new_list.append(file)
	
	return new_list # sorted list

## DEBUG: Reads out all of the found files
func print_files():
	print("File list:")
	for file: String in list:
		print(file)
