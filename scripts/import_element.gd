### Authored by Dawn2Dusk
### Implementation of ListElement for the import field
class_name ImportElement extends ListElement

signal add_pressed(file: String, path: String) ## Tells the playlist a new file is being added

## Triggers the add_pressed signal with local fields
func call_add_pressed():
	add_pressed.emit(file_name, full_path)
