class_name PlaylistElement extends ListElement

signal remove_element(element: PlaylistElement)
signal move_up(element: PlaylistElement)
signal move_down(element: PlaylistElement)
signal play(element: PlaylistElement)

## element fields
var element_index: int

## Connect all relevant signals
func connect_signals(playlist: Playlist):
	connect("remove_element", playlist.remove_from_playlist)
	connect("move_up", playlist.reorder_up)
	connect("move_down", playlist.reorder_down)
	connect("play", playlist.play_single)

func call_remove_element():
	remove_element.emit(self)

func call_move_up():
	move_up.emit(self)

func call_move_down():
	move_down.emit(self)

func call_play():
	play.emit(self)
