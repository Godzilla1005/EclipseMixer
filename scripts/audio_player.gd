class_name AudioPlayer extends Node

## Connections
@export var playlist: Playlist
@export var audio_player: AudioStreamPlayer

## Fields
var file_access: FileAccess
var current_song: AudioStreamMP3

## Stop playing music
func stop():
	audio_player.stop()
	file_access = null
	current_song = null

## Plays the song at the current index
func play_song(file: String):
	## Open the given file
	file_access = FileAccess.open(file, FileAccess.READ)
	
	## Check the result
	var result: Error = FileAccess.get_open_error()
	if result != OK or file_access == null:
		push_warning("Failed to access the next song! Error Code ", result)
		playlist.stop()
		return
	
	## Load the new song into memory
	current_song = AudioStreamMP3.new()
	current_song.data = file_access.get_buffer(file_access.get_length())
	
	## Play the newly stored song
	audio_player.stream = current_song
	audio_player.play()
	return
