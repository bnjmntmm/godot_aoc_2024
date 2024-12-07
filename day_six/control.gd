extends Control

var helper : HELPER
var testInput :String = "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."

var split_text


var canvas_width : int
var canvas_height : int


var current_guard_position : Vector2
var current_dir = "^"
##this will be villed with vector2(x,y) for the positions
var visited_locations : Array = []

##movement_dir_of_guard
var movement_dir : Dictionary = {
	"^" : Vector2(0,-1), ## UP
	">" : Vector2(1,0), ## RIGHT
	"v": Vector2(0,1), ## DOWN
	"<": Vector2(-1,0)  ## LEFT
}
var dir_icon : Array = ["^", ">", "v", "<"]


### RULES:
### IF GUARD HAS OBSTACLE IN FRONT -> TURN 90° Right
### LOOP
### IF GUARD LEAVES AREA -> DONE 
### COUNT THE DISTINCT POSTIONS (and starting positions)



func _ready() -> void:
	helper = HELPER.new()
	var fullText = helper.read_file("res://input/input.txt")
	split_text = fullText.split("\n")
	canvas_width = len(split_text[0])
	canvas_height = len(split_text)
	var start = Time.get_unix_time_from_system()
	taskOne()
	var end = Time.get_unix_time_from_system()
	print("it took:", end-start)


func taskOne():
	find_initial_guard_pos(split_text)
	move_the_guard()



## traverse through the whole array,
## check at which pos it is. Add it to the visited locations array
func find_initial_guard_pos(input) -> void:
	for y in range(0,canvas_height-1):
		for x in range(0,canvas_width):
			## checked in the big input. the guard also starts with ^
			if input[y][x] == "^":
				current_guard_position = Vector2(x,y)
				visited_locations.append(current_guard_position)
				current_dir = "^"
#### Process:
### Get Guard Dir
### first check if guard is of the map:
### if yes stop lol
### check if GuardPos + GuardDir != "#" -> GuardPos = GuardPos + GuardDir
### ELSE: TURN TO NEXT PHASE 
### 
func move_the_guard():
	var is_allowed_to_move = true
	var is_outside_of_map = false
	
	while is_allowed_to_move and not is_outside_of_map:
		var next_pos = current_guard_position + movement_dir[current_dir]
		if current_guard_position.x < 0 or current_guard_position.x >= canvas_width-1 or current_guard_position.y < 0 or current_guard_position.y >= canvas_height-1:
			is_allowed_to_move = false
			is_outside_of_map = true
		else:
			if split_text[next_pos.y][next_pos.x] != "#":
				current_guard_position = next_pos
				if next_pos not in visited_locations:
					visited_locations.append(next_pos)
			else:
				is_allowed_to_move = false
				var index = dir_icon.find(current_dir)
				index = (index + 1) % 4
				current_dir = dir_icon[index]
				move_the_guard()
	if is_outside_of_map:
		print("guard is outside")
		print("the guard visited: ",  len(visited_locations), " locations")
