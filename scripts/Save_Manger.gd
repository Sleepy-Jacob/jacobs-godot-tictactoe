extends Node


var save_path: String = "user://savedata.json"
var save_data: Dictionary = {}

func _ready() -> void:
	if not FileAccess.file_exists(save_path):
		save_game() #creates save file
	load_game()

##game mot saved to disk untill this is called
func save_game() -> void:
	var file:FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data, "\t"))
		file.close()
	else:
		print("Failed to save: ", FileAccess.get_open_error())
		breakpoint

## i hate the function clean it somtime
func load_game() -> void:
	if not FileAccess.file_exists(save_path):
		print("No save file found.")
		return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	var content = file.get_as_text()
	file.close()
		
	var parsed = JSON.parse_string(content)
	if parsed != null:
		save_data = parsed
		print("Game loaded: ", save_data)
	else:
		breakpoint
		#PASSING FALED
	

##not save permently untill save_game() is callled .all keys must be uneek
func save_value(key: String, value) -> void:
	save_data[key] = value

## shorter than going SaveManger.savedata.get()
func get_value(key: String, default = null):
	return save_data.get(key, default)
