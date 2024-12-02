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
	print(amount_of_safe_reports)

func task_two() -> void:
	for report in convertedArray:
		var is_decreasing = false
		var is_increasing = false
		for i in range(len(report)):
			if i != len(report)-1:
				var diff = report[i] - report[i+1]
				if 1 <= diff and diff <= 3:
					if is_decreasing:
						#print("was increasing and now decreased")
						if recursion_check(report, i+1):
							amount_of_safe_reports +=1
						break
					#print("diff ok and increasing")
					is_increasing = true
				elif -3 <= diff and diff <= -1:
					if is_increasing:
						#print("was decreasing and now decreased")
						if recursion_check(report, i+1):
							amount_of_safe_reports +=1
						break
					#print("diff ok and decreasing ")
					is_decreasing = true
				else:
					#print("range to far apart")
					if recursion_check(report, i+1):
							amount_of_safe_reports +=1
					break
			else:
				if is_decreasing or is_increasing:
					amount_of_safe_reports+=1
	print(amount_of_safe_reports)
	
func recursion_check(input : Array,remove_index : int) -> bool:
	var removed_array = input.duplicate()
	removed_array.remove_at(remove_index)
	var is_decreasing = false
	var is_increasing = false
	for i in range(len(removed_array)):
		if i != len(removed_array)-1:
			var diff = removed_array[i] - removed_array[i+1]
			if 1 <= diff and diff <= 3:
				if is_decreasing:
					break
				is_increasing = true
			elif -3 <= diff and diff <= -1:
				if is_increasing:
					break
				is_decreasing = true
			else:
				break
		else:
			if is_decreasing or is_increasing:
				return true
	return false
