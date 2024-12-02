extends Control

var helper : HELPER
var inputArray : Array
var convertedArray : Array

var amount_of_safe_reports:int = 0

func input_to_array(array : Array):
	var test = array[0]
	var string_array = test.split(" ")
	var int_array = []
	for item in string_array:
		int_array.append(int(item))
	return int_array

func _ready() -> void:
	helper = HELPER.new()
	inputArray =  helper.read_file_to_list("res://input/input.txt")
	for line in inputArray:
		convertedArray.append(input_to_array(Array(line)))
	task_two()
	
### REFACTORED WITH FUNCTIONS AFTER TASK ONE


func task_one() -> void:
	for report in convertedArray:
		var is_decreasing = false
		var is_increasing = false
		for i in range(len(report)):
			if i != len(report)-1:
				var diff = report[i] - report[i+1]
				if 1 <= diff and diff <= 3:
					if is_decreasing:
						#print("was increasing and now decreased")
						break
					#print("diff ok and increasing")
					is_increasing = true
				elif -3 <= diff and diff <= -1:
					if is_increasing:
						#print("was decreasing and now decreased")
						break
					#print("diff ok and decreasing ")
					is_decreasing = true
				else:
					#print("range to far apart")
					break
			else:
				if is_decreasing or is_increasing:
					amount_of_safe_reports+=1
func task_two() -> void:
	##basically do task one but if one fails. remove the error bit and try again
	for report in convertedArray:
		var is_decreasing = false
		var is_increasing = false
		for i in range(len(report)):
			if i != len(report)-1:
				var diff = report[i] - report[i+1]
				if 1 <= diff and diff <= 3:
					if is_decreasing:
						#print("was increasing and now decreased")
						var temp_array : Array = report.duplicate()
						var j = i+1
						temp_array.pop_at(j)
						check_recursion(temp_array)
						break
					#print("diff ok and increasing")
					is_increasing = true
				elif -3 <= diff and diff <= -1:
					if is_increasing:
						#print("was decreasing and now decreased")
						var temp_array : Array = report.duplicate()
						var j = i+1
						temp_array.pop_at(j)
						check_recursion(temp_array)
						break
					#print("diff ok and decreasing ")
					is_decreasing = true
				else:
					var temp_array : Array = report.duplicate()
					var j = i+1
					temp_array.pop_at(j)
					check_recursion(temp_array)
					break
			else:
				if is_decreasing or is_increasing:
					amount_of_safe_reports+=1
	print(amount_of_safe_reports)


## sadly wrong.. I am missing some iteration though  
func check_recursion(small_array: Array):
	var is_decreasing = false
	var is_increasing = false
	for i in range(len(small_array)):
		if i != len(small_array)-1:
			var diff = small_array[i] - small_array[i+1]
			if 1 <= diff and diff <= 3:
				if is_decreasing:
					#print("was increasing and now decreased")
					break
					#print("diff ok and increasing")
				is_increasing = true
			elif -3 <= diff and diff <= -1:
				if is_increasing:
					#print("was decreasing and now decreased")
					break
					#print("diff ok and decreasing ")
				is_decreasing = true
			else:
				#print("range to far apart")
				break
		else:
			if is_decreasing or is_increasing:
				amount_of_safe_reports+=1
			
			
