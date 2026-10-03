### Authored by Dawn2Dusk
### Implementation of ListElement that includes signals for interfacing with the Playlist
class_name PlaylistElement extends ListElement

signal remove_element(element: PlaylistElement) ## Destroy this element
signal move_up(element: PlaylistElement) ## Move this element higher
signal move_down(element: PlaylistElement) ## Move this element lower
signal play(element: PlaylistElement) ## Play this element individually

## element fields
var element_index: int

## Connect all relevant signals
func connect_signals(playlist: Playlist):
	connect("remove_element", playlist.remove_from_playlist)
	connect("move_up", playlist.reorder_up)
	connect("move_down", playlist.reorder_down)
	connect("play", playlist.play_single)

## Calls remove_element on self
func call_remove_element():
	remove_element.emit(self)

## Calls move_up on self
func call_move_up():
	move_up.emit(self)

## Calls move_down on self
func call_move_down():
	move_down.emit(self)

## Calls play on self
func call_play():
	play.emit(self)
