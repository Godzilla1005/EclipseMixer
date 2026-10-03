@abstract class_name ListBuilder extends Control

## element to add
@export var element_scene: PackedScene

## list variables
var list_elements: Array[ListElement]

## Initializes the creation of a list from a given PackedStringArray
func create_list(list: PackedStringArray):
	# add and element for every file
	for file in list:
		add_to_list(file)

## Adds a new element to the list with the given file name
func add_to_list(file: String) -> ListElement:
	# create new element and add it to list
	var new_element: ListElement = element_scene.instantiate()
	add_child(new_element)
	list_elements.append(new_element)
	
	# prepare information
	_setup_element(new_element, file)
	return new_element

## Removes an element from the list with the given file name
func remove_by_file(file: String):
	# find the file in the list
	for element in list_elements:
		if element.file_name == file:
			# delete this element
			list_elements.erase(element)
			element.queue_free()

## Removes an element from the list with the given index
func remove_by_index(index: int):
	# pop the element at that index and free it
	var element: ListElement = list_elements.pop_at(index)
	element.queue_free()

## Clears and destroys all list elements
func clear_list():
	if list_elements.size() <= 0: return
	
	# free every element
	for element in list_elements:
		element.queue_free()
	
	# reset the list
	list_elements.clear()

@abstract func _setup_element(element: ListElement, file: String)
