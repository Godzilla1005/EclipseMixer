### Authored by Dawn2Dusk
### Class that handles the behavior of the playlist, including adding, removing, and playing
class_name Playlist extends Node

## What state the playlist is currently in
enum PlayMode {
	NONE,
	PLAY,
	SHUFFLE,
}

## Connections
@export var audio_player: AudioPlayer
@export var elements: PlaylistBuilder
@export var importer: Importer
@export var preset: PackedScene
@export var preset_list: Control
@export var currently_playing: RichTextLabel

## Playlist Fields
var playing_index: int = 0
var playing: bool = false
var play_mode: PlayMode = PlayMode.NONE
var active_element: PlaylistElement


## Play straight through the playlist
func play():
	playing = true
	play_mode = PlayMode.PLAY
	active_element = elements.get_child(0)
	audio_player.play_song(active_element.full_path)
	set_currently_playing(active_element.element_name.text)

## Attempt to play a random audio
func shuffle():
	playing = true
	play_mode = PlayMode.SHUFFLE
	active_element = elements.get_child(randi_range(0, elements.get_child_count() - 1))
	audio_player.play_song(active_element.full_path)
	set_currently_playing(active_element.element_name.text)

## Play a single audio file once
func play_single(element: PlaylistElement):
	playing = true
	play_mode = PlayMode.NONE
	active_element = element
	audio_player.play_song(active_element.full_path)
	set_currently_playing(active_element.element_name.text)

## Stop the currently playing audio
func stop():
	audio_player.stop()
	playing = false
	play_mode = PlayMode.NONE
	active_element = null
	set_currently_playing("None")

## Tell the playlist to add a new audio file
func add_to_playlist(file: String, path: String):
	## create the new element
	var element: PlaylistElement = elements.add_to_list(file)
	
	## initialize the new element
	element.setup(file, path)
	element.connect_signals(self)
	element.element_index = elements.get_child_count() - 1

## Removes the passed element from the playlist and frees the node
func remove_from_playlist(element: PlaylistElement):
	## remove the element
	elements.remove_by_file(element.file_name)
	
	## reorder the remaining elements
	for i: int in range(elements.get_child_count()):
		elements.get_child(i).element_index = i

## Moves an element higher in the order
func reorder_up(element: PlaylistElement):
	## check the current index
	var current_index: int = element.element_index
	if current_index == 0: return
	
	## reorder the components and update their indices
	elements.move_child(element, current_index - 1)
	element.element_index = current_index - 1
	elements.get_child(current_index).element_index = current_index

## Moves an element lower in the order
func reorder_down(element: PlaylistElement):
	## check the current index
	var current_index: int = element.element_index
	if current_index == elements.get_child_count() - 1: return
	
	## reorder the components and update their indices
	elements.move_child(element, current_index + 1)
	element.element_index = current_index + 1
	elements.get_child(current_index).element_index = current_index

## Triggered when the currently playing audio is finished
func player_finished() -> void:
	if !playing or elements.get_child_count() == 0: 
		stop()
		return # nothing else to play
	
	## determine next action
	match play_mode:
		PlayMode.NONE:
			return # nothing else to play
		PlayMode.PLAY:
			## play the next element in order
			playing_index = playing_index + 1 if playing_index < elements.get_child_count() - 1 else 0 # loop to 0 if at the end
		PlayMode.SHUFFLE:
			## select a random element to play
			playing_index = randi_range(0, elements.get_child_count() - 1)
	
	## play the new audio
	active_element = elements.get_child(playing_index)
	audio_player.play_song(active_element.full_path)
	set_currently_playing(active_element.element_name.text)

## Creates a preset with the currently loaded elements
func save_playlist():
	## create the new preset
	var new_preset: PlaylistPreset = preset.instantiate()
	
	## create an array with the current elements
	var temp_array: PackedStringArray
	for element: PlaylistElement in elements.get_children():
		temp_array.append(element.file_name)
	if temp_array.size() <= 0: return
	
	## set up the new preset
	preset_list.add_child(new_preset)
	new_preset.setup_list(temp_array, self, importer, "New Preset")

## Clear every active element
func clear_playlist():
	elements.clear_list()

## Displays the currently playing element's title
func set_currently_playing(title: String):
	currently_playing.text = title
