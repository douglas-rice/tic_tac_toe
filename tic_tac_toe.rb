require 'pry'

# 1. Come up with requirements/specification, which will determine the scope.
# 2. Applicaiton logic: sequence of actions that need to be taken in order
#    to fullfill requirements.
# 3. Translation of those steps into code
# 4. Run code to verify logic.

# 1) draw a board

# assign player to "X"
# assign computer to "O"

# 2) loop until a winner or all squares are taken
#   player picks an empty square
#   check for a winner (somehow saves it into a var outside the loop)
#   computer picks an empty square
#   check for a winner

# if there is a winner
#   show the winner
# or else
#   it is a tie

# NOTES:
# At each stage (each line of pseudocode), Chris created a new method.
# So: Each step of pseudocode is a new method.

# We need a way to keep track of the squares, to keep track of the board.
# How about a hash, where the keys are the position numbers

# 23:42 part in video about keeping track of board

# Whenever we "pass in the board" (to a method), we're simply passing
# in that hash of keys and values.

# when you pass in the "board" hash, you have to use its name ('board'),
# but the argument in the method definition itself is just a placeholder,
# so it can be anything, hence why we called it 'b' throughout the program.

# IMPROVEMENTS TO MAKE:

# Show available squares in player_picks_squre method.
# Also, control for if player doesn't choose an available square
# Add intelligence for computer's choices

######### Methods ####################################################

# build the hash that holds the positions
# hash contains the numbers 1 - 9 and what the positions are
# the keys are the position numbers (an integer)
# value of key is whatever we display in that position
# could be an 'X', could be an 'O', could be an empty string (' ')
# provides getable and setable position values
# this is my data structure, this hash, this is what i'm gonna use to
# keep track of the values, where the X's are and where the O's are.
# I'm gonna go ahead and create a variable called "board" and basically
# pass this variable around. 
# Before I draw the board, I want to initialize the board.
# Note: this is only done once.  It's empty and then gets modified as the
# game progresses.
def initialize_board
  b = {}  # let's just call this 'b' because it's a local variable
  (1..9).each {|position| b[position] = ' '}  # builds hash structure
  return b
end

# 1) draw a board (method)
def draw_board(b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "-----------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "-----------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

# The board is a hash
# Iterate through this hash and select the values that are empty.
# Returns those keys that have spaces for values.
def empty_positions(b)
  b.select {|key, value| value == ' '}.keys  # returns array of keys whose values are empty
end 

# 2) player picks an empty square
def player_picks_square(b)
  puts "Pick a square (1 - 9):"
  position = gets.chomp.to_i
  b[position] = 'X'
end

# 2) computer picks an empty square
def computer_picks_square(b)
  # the computer needs to find an empty square, so we need a method
  # to list the choices of empty positions. (let's go create one)
  position = empty_positions(b).sample  # samples one of those keys whose values are empty
  b[position] = 'O' # assign the value 'O' to that position.
end

def check_winner(b)
  # brute force way of determining winning lines
  # create an array with the winning combos...
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], 
                   [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  # so now we want to iterate through the winning lines and see if any
  # of these array positions have three X's or three O's.
  winning_lines.each do |line|  # 'line' is an array
    return "Player" if b.values_at(*line).count('X') == 3
    return "Computer" if b.values_at(*line).count('O') == 3
  end
  nil
end

######### Program ####################################################

# 1) have to first initialize board before drawing it...
# I'm gonna go ahead and create a variable called "board" and basically
# pass this variable around. 
# 'b' from the method is set to 'board' at the main scope
# this board variable is what we are going to use to keep track of the state
# of the board and the values of each position.
# 'board' is simply the hash! (don't think about the drawing. that is separate)
board = initialize_board

# 1) draw board (call draw board method)
# in order to draw the board i need to pass in this 'board' variable.
draw_board(board)

# loop until a winner or all squares are taken
# To have player pick a square, we're gonna have to pass in the board hash again.

begin
  player_picks_square(board)     # step 2 in pseudocode
  computer_picks_square(board)
  # after the players pick, we want to draw the board again, right?
  draw_board(board)
  # now we want to check if there is a winner
  # for some reason we want to set a variable, called "winner"
  winner = check_winner(board)
  # game loops until there is a winner, or all squares are taken.
  # we need a method to test when the game is over (when all squares are taken)
end until winner || empty_positions(board).empty? # we need to test that there are no more empty positions

if winner
  puts "#{winner} won!"
else
  puts "It's a tie :( "
end


######### alternate check_winner method ###################

# def check_winner(b)
#   # brute force way of determining winning lines
#   # create an array with the winning combos...
#   winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], 
#                    [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
#   # so now we want to iterate through the winning lines and see if any
#   # of these array positions have three X's or three O's.
#   winning_lines.each do |line|  # 'line' is an array
#       # what we're trying to check to see if each if the board at each of the
#       # positions equals either 'X' or 'O' and they have to be the same
#       if b[line[0]] == 'X' and b[line[1]] == 'X' and b[line[2]] == 'X'
#         return 'Player'
#       elsif b[line[0]] == 'O' and b[line[1]] == 'O' and b[line[2]] == 'O'
#         return 'Computer'
#       else
#         return nil
#   end
# end






