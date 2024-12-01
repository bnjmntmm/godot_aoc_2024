extends Control


var helper : HELPER
var content : Array

var left_list : Array
var right_list : Array

func _ready() -> void:
	helper = HELPER.new()
	content = helper.read_file_to_list("res://input/input.txt")#
	## parse as int and add to specific list
	for item in content:
		left_list.append(int(item[0]))
		right_list.append(int(item[1]))
	
	## sort them
	left_list.sort()
	right_list.sort()
	


func taskOne():
	var shortest_distances : Array = []
	
	for i in range(len(right_list)):
		#$TaskOneView/leftText/item.text = str(abs(left_list[i]))
		#$TaskOneView/rightText/item.text = str(abs(right_list[i]))
		var val = abs(left_list[i] - right_list[i])
		#$TaskOneView/sumText/item.text = str(val)
		shortest_distances.append(val)
	var sum = shortest_distances.reduce(helper.sum, 0)
	print(sum)

func taskTwo():
	var numbers : Array
	var similarity_score : int
	for item in left_list:
		## Count returns the number of times an element is in the array.
		var occurences = right_list.count(item)
		numbers.append([item, occurences])
	
	## now calc 
	for item in numbers:
		similarity_score += (item[0] * item[1])
	print(similarity_score)
