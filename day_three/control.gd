extends Control

var helper: HELPER

var test_string : String = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
var second_test_string : String = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
var long_array
var calculation_array = []
var hä_array = []
var sum = 0
var is_allowed_to_add = true

func _ready() -> void:
	#task_one()
	helper = HELPER.new()
	long_array = helper.read_file_to_list("res://helper/input.txt")
	taskTwo()
	
func taskOne():
	for entry in long_array:
		mulRegex(entry[0])
	for calc in calculation_array:
		sum += calc
	print(sum)

func taskTwo():
	for entry in long_array:
		mulRegexWithDo(entry[0])
	for calc in calculation_array:
		sum += calc
	print(sum)


func mulRegex(input_string: String):
	var main_regex = RegEx.new()
	#main_regex.compile("mul\\(([0-9]|[1-9][0-9]|[1-9][0-9][0-9]),([0-9]|[1-9][0-9]|[1-9][0-9][0-9])\\)")
	main_regex.compile("mul\\(\\d{1,3},\\d{1,3}\\)")
	for result in main_regex.search_all(input_string):
		##smaller_regex.compile("([0-9]|[1-9][0-9]|[1-9][0-9][0-9]),([0-9]|[1-9][0-9]|[1-9][0-9][0-9])")
		## this somehow wont return every type eventhough regex101.com does lol
		var string = result.get_string()
		string = string.replace("mul(", "").replace(")", "").split(",")
		calculation_array.append(int(string[0]) * int(string[1]))
	
func mulRegexWithDo(input_string: String):
	var main_regex = RegEx.new()
	main_regex.compile("(do\\(\\)|don't\\(\\))|mul\\(\\d{1,3},\\d{1,3}\\)")
	for result in main_regex.search_all(input_string):
		var result_string = result.get_string()
		if result_string == "don't()":
			is_allowed_to_add = false
		elif result_string == "do()":
			is_allowed_to_add = true
		else:
			if is_allowed_to_add:
				result_string = result_string.replace("mul(", "").replace(")", "").split(",")
				calculation_array.append(int(result_string[0]) * int(result_string[1]))
