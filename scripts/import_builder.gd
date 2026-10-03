class_name ImportBuilder extends ListBuilder

## Connections
@export var importer: Importer
@export var playlist: Playlist

## Local Fields
var import_element: ImportElement

func _setup_element(element: ListElement, file: String):
	import_element = element if element is ImportElement else null
	
	var full_path: String = importer.path.path_join(file)
	element.setup(file, full_path)
	
	if import_element == null: 
		push_warning("The import builder made something other than an ImportElement: ", file)
		return
	
	import_element.connect("add_pressed", playlist.add_to_playlist)
	return
