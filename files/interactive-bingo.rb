# U2.W5: A Nested Array to Model a Bingo Board SOLO CHALLENGE

# I spent [#] hours on this challenge.


# Release 0: Pseudocode
# Outline:

# Create a method to generate a letter ( b, i, n, g, o) and a number (1-100)
  #fill in the outline here

# Check the called column for the number called.
  #fill in the outline here

# If the number is in the column, replace with an 'x'
  #fill in the outline here

# Display a column to the console
  #fill in the outline here

# Display the board to the console (prettily)
# bingo_board.each {|row| p row}

# Release 1: Initial Solution

class BingoBoard
  attr_reader :bingo_board, :action
  def initialize
    @bingo_board = new_game
    user_action?
    user_response(action)
  end

  def call(letter, number)
    @count += 1
    puts "
    Round #{@count}"
    bingo_board.each {|x| 
      if x[letter_to_index(letter)] == number
        x[letter_to_index(letter)] = "X"
        check_win_hor(bingo_board.index(x), letter_to_index(letter))
        check_win_vert
        check_win_dia
      end
      }
      bingo_board.each {|row| p row}
      user_action?
  end

  def user_action?
    puts "
    Please tell me a letter from the word 'BINGO', or use available commands: 'new' or 'exit'"
    action = gets.chomp!
    user_response(action)
  end

  def user_response(action)
    bingo_str = "bingo"
    if action == "new"
      initialize
    elsif bingo_str.include?(action.downcase)
      letter = action
      puts "Please tell me a number between 1-75"
      number = gets.chomp!.to_i
      until number > 0 && number < 76
        puts "Please enter a valid number between 1-75"
        number = gets.chomp!.to_i
      end
        call(letter, number)
    elsif action == "exit" 
      return nil
    else
      puts "Please enter a valid entry"
      user_action?
    end
  end

  def check_win_hor(y_index, x_index) # an experiement to make it "smart" enough to detect
    count = 1
    left = x_index - 1
    right = x_index + 1
    until left < 0
      if bingo_board[y_index][left] == "X"
        count += 1
      else
        left -= 10
      end
      left -= 1
    end
    while right < bingo_board[y_index].length
      if bingo_board[y_index][right] == "X"
        count +=1
      else
        right += 10
      end
      right += 1
    end

    if count == 5
      puts "Hey, you won! Want to start another game?"    
    end
  end

  def check_win_vert
    puts "Hey, you won! Want to start another game?" if bingo_board[0][0] == "X" && bingo_board[1][0] == "X" && bingo_board[2][0] == "X" && bingo_board[3][0] == "X" && bingo_board[4][0] == "X" 
    puts "Hey, you won! Want to start another game?" if bingo_board[0][1] == "X" && bingo_board[1][1] == "X" && bingo_board[2][1] == "X" && bingo_board[3][1] == "X" && bingo_board[4][1] == "X" 
    puts "Hey, you won! Want to start another game?" if bingo_board[0][2] == "X" && bingo_board[1][2] == "X" && bingo_board[2][2] == "X" && bingo_board[3][2] == "X" && bingo_board[4][2] == "X" 
    puts "Hey, you won! Want to start another game?" if bingo_board[0][3] == "X" && bingo_board[1][3] == "X" && bingo_board[2][3] == "X" && bingo_board[3][3] == "X" && bingo_board[4][3] == "X" 
    puts "Hey, you won! Want to start another game?" if bingo_board[0][4] == "X" && bingo_board[1][4] == "X" && bingo_board[2][4] == "X" && bingo_board[3][4] == "X" && bingo_board[4][4] == "X" # "dumb" way to check
  end

  def check_win_dia
    puts "Hey, you won! Want to start another game?" if bingo_board[0][0] == "X" && bingo_board[1][1] == "X" && bingo_board[2][2] == "X" && bingo_board[3][3] == "X" && bingo_board[4][4] == "X" 
    puts "Hey, you won! Want to start another game?" if bingo_board[4][0] == "X" && bingo_board[3][1] == "X" && bingo_board[2][2] == "X" && bingo_board[1][3] == "X" && bingo_board[0][4] == "X" # "dumb" way to check
  end

  def new_game
    @bingo_board = []
    starting = 1
    ending = 15
    5.times {|x|
      arr = []
      5.times {|y| 
        arr << rand(starting...ending)}
      @bingo_board << arr
      starting += 15
      ending += 15
    }
    @count = 0
    @bingo_board[2][2] = "X"
    puts "
    A New Game Has Started. This is your new randomized card!"
    @bingo_board.each {|array| p array}
  end

  def letter_to_index(letter)
    letter.upcase!
    if letter == "B"
      0
    elsif letter == "I"
      1
    elsif letter == "N"
      2
    elsif letter == "G"
      3
    elsif letter == "O"
      4
    else
      raise ArgumentError.new("Invalid Argument. Please input any letters from the word 'BINGO'")
    end
  end
end

# run the game!
BingoBoard.new 

# Release 3: Refactored Solution



# Release 2: DRIVER TESTS GO BELOW THIS LINE
# board = [[47, 44, 71, 8, 88],
#         [22, 69, 75, 65, 73],
#         [83, 85, 97, 89, 57],
#         [25, 31, 96, 68, 51],
#         [75, 70, 54, 80, 83]]
# test = BingoBoard.new
# test.call("n", 97)
# test.call("n", 73)

# test.call("g", 8)
# test.call("b", 83)
# test.call("i", 85)
# test.call("g", 89)
# test.call("n", 54)
# test.call("o", 1)
# test.call("G", 22)
# test.call("g", 80)
# test.call("g", 65)
# test.call("g", 68)

# Release 4: Reflection

# This exercise is very fun. I'm thinking about adding a bunch more methods to it! However, it takes a lot of time for me to build them. Like, I made a method that check if we have 5 "X" horizontally cross the board. It will prompt player they win upon reaching the condition. For now I only got the horizontal works, I'm not sure why the vertical checker doesn't work. I think I'll put more time and keep building on this fun little project later in this week.

