extends Control

var helper : HELPER

var test_input = "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20"

var operators = ["+", "*", "||"]

func _ready() -> void:
	helper = HELPER.new()	
	
	
func task_one(parsed_input):
	var valid_values = []
	for row in parsed_input:
		print("new row")
		#split input into target value and equation
		var row_split = row.split(":")
		var target_value = int(row_split[0].strip_edges())
		var equation = row_split[1].strip_edges().replace(" ", ",")
		
		## split the numbers and count potential operator pos
		var numbers = equation.split(",")
		var operator_pos = numbers.size() -1
		for op_combination in generate_operator_combinations(operator_pos):
			var eval_equation = []
			eval_equation.append(str(numbers[0]))
			##generate all possible equations
			for i in range(operator_pos):
				eval_equation.append(op_combination[i])
				eval_equation.append(numbers[i+1])
			##calc the equation
			var result = save_eval(eval_equation)
			if result == target_value:
				valid_values.append(target_value)
				break
	print(calculate_sum_of_values(valid_values))
	
		
func generate_operator_combinations(operator_count):
	var results = []
	if operator_count == 0:
		return [[]]
	for op in operators:
		for sub_combination in generate_operator_combinations(operator_count -1):
			results.append([op]+ sub_combination)
	return results


func calculate_sum_of_values(values) -> int:
	var sum : int = 0
	for val in values:
		sum += val
	return sum

###calculate the equation
func save_eval(eval_equation):
	var value = int(eval_equation[0])
	for i in range(len(eval_equation)):
		if eval_equation[i] == "+":
			if i+1 <= len(eval_equation):
				var next_value = eval_equation[i+1]
				value *= int(next_value)
		elif eval_equation[i] == "*":
			if i+1 <= len(eval_equation):
				var next_value = eval_equation[i+1]
				value += int(next_value)
				
		## this part for part2
		elif eval_equation[i] == "||":
			if i+1 <= len(eval_equation):
				var next_value = eval_equation[i+1]
				var prevValueAsString = str(value)
				var combinesVal = prevValueAsString+next_value
				value = int(combinesVal)
	return value
				


func _on_button_button_down() -> void:
	var big_input = helper.read_file("res://input/input.txt")
	var parsed_big_input = big_input.split("\n")
	parsed_big_input.remove_at(len(parsed_big_input)-1)
	
	task_one(parsed_big_input)
