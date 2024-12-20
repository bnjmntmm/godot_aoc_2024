extends Control

var helper : HELPER


var test_input = "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"


var page_ordering_rules = []
var pages_to_produce = []

var incorrectly_ordered_pages = []
var newly_ordered_pages = []

var correctly_ordered_pages = []
var middle_numbers = []


func _ready() -> void:
	helper = HELPER.new()
	task_two()
	
func task_one() -> void:
	var text = helper.read_file("res://input/input.txt")
	var split = text.replace("\n", ";")
	var splitted = split.split(";;")
	var rules = splitted[0]
	rules = rules.split(";")
	var produces = splitted[1]
	produces = produces.split(";")

	for rule in rules:
		var seperated = rule.split("|")
		page_ordering_rules.append([int(seperated[0]),int(seperated[1])])
	
	for produce in produces:
		var entry = []
		for line: String in produce.split(","):
			entry.append(int(line))
		pages_to_produce.append(entry)
	check_the_rules()
	#print(get_middle_page_numbers(correctly_ordered_pages))
		
		
		
func task_two():
	## For each of the incorrectly-ordered updates, use the page ordering rules to put the page numbers in the right order.
	var time_start = Time.get_unix_time_from_system()
	var text = helper.read_file("res://input/input.txt")
	###TESTINPUT NEEDS TO BE REPLACED WITH TEXT
	var split = text.replace("\n", ";")
	var splitted = split.split(";;")
	var rules = splitted[0]
	rules = rules.split(";")
	var produces = splitted[1]
	produces = produces.split(";")

	for rule in rules:
		var seperated = rule.split("|")
		page_ordering_rules.append([int(seperated[0]),int(seperated[1])])
	
	for produce in produces:
		var entry = []
		for line: String in produce.split(","):
			entry.append(int(line))
		pages_to_produce.append(entry)
	check_the_rules()
	
	for unordered_page in incorrectly_ordered_pages:
		sort_incorrectly_ordered_pages(unordered_page)
	var result = get_middle_page_numbers(newly_ordered_pages)
	var time_end = Time.get_unix_time_from_system()
	
	print("Sum of middle numbers: ",result)
	print("Elapsed Time: ", time_end-time_start)
	


func sort_incorrectly_ordered_pages(array_to_be_sorted: Array) -> void:
	var sorted = true
	for rule in page_ordering_rules:
		var rule_one_index : int = array_to_be_sorted.find(rule[0])
		var rule_two_index : int = array_to_be_sorted.find(rule[1])
		if rule_one_index != -1 and rule_two_index != -1 and rule_one_index > rule_two_index:
			##swap
			var temp = array_to_be_sorted[rule_one_index]
			array_to_be_sorted[rule_one_index] = array_to_be_sorted[rule_two_index]
			array_to_be_sorted[rule_two_index] = temp
			sorted = false
	if not sorted:
		##do it again
		sort_incorrectly_ordered_pages(array_to_be_sorted)
	
	if array_to_be_sorted not in newly_ordered_pages:
		newly_ordered_pages.append(array_to_be_sorted)
		
func check_the_rules() -> void:
	##check if number of rule[0] is inside line, save the index,
	## check if number of rule[1] is inside line, save the index
	##index von rule[0] < index von rule[1]: if true -> continue, else break
	for update_list : Array in pages_to_produce:
		#update_list = [75, 47, 61, 53, 29]
		var rules_applied : bool = true
		for rule in page_ordering_rules:
			var ruleOneIndex : int = update_list.find(rule[0])
			var ruleTwoIndex : int = update_list.find(rule[1])
			if ruleOneIndex != -1 and ruleTwoIndex != -1:
				if ruleOneIndex < ruleTwoIndex:
					##then the rule is correct
					continue
				else:
					rules_applied = false
					break
		##if rules are applied and correct -> 
		if rules_applied:
			correctly_ordered_pages.append(update_list)
		else:
			incorrectly_ordered_pages.append(update_list)
			
func get_middle_page_numbers(array: Array) -> int:
	var sum = 0
	middle_numbers.clear()

	for pages: Array in array:
		var middle = int(len(pages) / 2)
		var numb = pages[middle]
		middle_numbers.append(numb)

	for number in middle_numbers:
		sum += number

	return sum
