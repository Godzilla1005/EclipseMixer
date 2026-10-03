### Authored by Dawn2Dusk
### Implementation of ListBuilder that handles ImportElements
class_name ImportBuilder extends ListBuilder

## Connections
@export var importer: Importer
@export var playlist: Playlist

## Local Fields
var import_element: ImportElement

## Override: Initializes the newly created element with relevant file data and connections
func _setup_element(element: ListElement, file: String):
	## re-save this ListElement as an ImportElement
	import_element = element if element is ImportElement else null
	
	## setup the new element
	var full_path: String = importer.path.path_join(file)
	element.setup(file, full_path)
	
	## check if this is an ImportElement
	if element is ImportElement: 
		## it is, connect signal
		import_element.connect("add_pressed", playlist.add_to_playlist)
		return
	else:
		## this is an error because and ImportBuilder should not be creating anything other than ImportElements
		push_error("The import builder made something other than an ImportElement: ", file)
		return
