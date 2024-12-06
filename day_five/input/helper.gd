extends Node
class_name HELPER

func read_file_to_list(path: String) -> Array:
	var result: Array = []
	var file := FileAccess.open(path, FileAccess.READ)
	
	if file:
		# Read the content of the file as text
		var content: String = file.get_as_text()
		
		# Split the content into lines
		var lines: Array = content.split("\n")
		
		# Process each line
		for line : String in lines:
			if line.strip_edges() == "": # Skip empty lines
				continue
			var splitted = line.split("   ")
			result.append(splitted)
	
	return result


func read_file(path) -> String:
	var file := FileAccess.open(path, FileAccess.READ)
	var content : String
	if file:
		content = file.get_as_text()
	return content
	
