class_name ImportElement extends ListElement

signal add_pressed(file: String, path: String)

func call_add_pressed():
	add_pressed.emit(file_name, full_path)
