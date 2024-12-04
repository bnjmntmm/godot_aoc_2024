extends Control

var helper : HELPER
var long_input


var test_input = "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"




var occurances = 0



func _ready() -> void:
	helper = HELPER.new()
	long_input = helper.read_file("res://input/input.txt")
	var split_long_input : Array = long_input.split("\n")
	split_long_input.remove_at(len(split_long_input)-1)
	#print(split_long_input)
	
	##tried 1893
	count_X_Shaped_Mas(split_long_input)


	
	
	
	


func count_X_Shaped_Mas(input):
	occurances = 0
	for i in range(0,len(input)-1):
		for j in range(0,len(input[0])-1):
			
			## if at i and j is an A
			## input[i-1][j+1] should be either M or S
			## if it is M then input[i+1[j-1] should be S, if it is S then M
			## and same for top right and bottom left
			##	[i-1,j+1]	[i+1,j+1]
			##			[i,j]
			##	[i-1,j-1]	[i+1,j-1]
			
			if input[i][j] == "A":
				if input[i-1][j+1] == "M" and input[i+1][j-1] == "S" or input[i-1][j+1] == "S" and input[i+1][j-1] == "M" :
					if input[i-1][j-1] == "M" and input[i+1][j+1] == "S" or input[i-1][j-1] == "S" and input[i+1][j+1] == "M":
						print("i: ", i, "j: ", j)
						occurances += 1
	print(occurances)
	
func count_xmas(input):
	occurances = 0
	rows(input)
	columns(input)
	directionals(input)
	print(occurances)
	
	
func parse_input(entry):
	##looking for xmas
	for i in range(len(entry)-3):
		if entry[i] == "X" and entry[i + 1] == "M" and entry[i + 2] == "A" and entry[i + 3] == "S":
			occurances += 1

###forwards and backwards for each row
func rows(input):
	##rows
	for entry in input:
		##forwards
		parse_input(entry)
		#backwards
		var reversed_entry = entry.reverse()
		parse_input(reversed_entry)

#
###each column forwards and backwards
func columns(input):
	var column_strings : Array = []
	for col in range(len(input[0])): # Assuming rectangular grid
		var column_str = ""
		for row in input:
			column_str += row[col]
		column_strings.append(column_str)
	
	for entry in column_strings:
		# Top-to-bottom
		parse_input(entry)
		# Bottom-to-top
		parse_input(entry.reverse())

func directionals(input):
	for i in range(len(input)):
		for j in range(len(input[0])):
			if input[i][j] == "X":
				##forwards
				if (i+3 < len(input) and j +3 < len(input[i])):
					if(input[i+1][j+1] == "M" and input[i+2][j+2] == "A" and input[i+3][j+3] == "S"):
						occurances += 1
				##backwards
				if (i-3 >= 0 and j -3  >= 0):
					if(input[i-1][j-1] == "M" and input[i-2][j-2] == "A" and input[i-3][j-3] == "S"):
						occurances += 1
				##up
				if (i-3 >= 0 and j +3 < len(input[i])):
					if(input[i-1][j+1] == "M" and input[i-2][j+2] == "A" and input[i-3][j+3] == "S"):
						occurances += 1
				##down
				if (i+3 < len(input) and j - 3 >= 0):
					if(input[i+1][j-1] == "M" and input[i+2][j-2] == "A" and input[i+3][j-3] == "S"):
						occurances += 1
