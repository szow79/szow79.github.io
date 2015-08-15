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
$event_list = [
  "A bad guy just robbed your card. Now you have to start over!",
  "Errr... A strong wind blew away your card and there is no way you can get it back. Please start over!",
  "Your dog ate your card. Go get a new one!",
  "You found out your card is fake and you have to remake one for the next game!",
  "Oops someone else won before you do. A new game starts.",
  "You fell asleep. A new game has started when you wake up.",
  "Your card was caught on fire and burned. You pick up a new card.",
  "Oh wait...You just realized this is not your card. Go get your own card!"
]

class BingoBoard
  def initialize
    @bingo_board = new_game
    @win = false
    @difficulty = 5
  end

  def new_game
    @bingo_board = []
    starting = 1
    ending = 15
    5.times do |x|
      arr = []
      5.times {|y| arr << rand(starting...ending)}
      @bingo_board << arr
      starting += 15
      ending += 15
    end
    @count = 0
    @bingo_board[2][2] = "X"
    puts "
    A new game has started. This is your new randomized card!"
    @bingo_board.each {|array| p array}
    user_action?
  end

  def user_action?
    puts "
    Please tell me a letter from the word 'bingo', or use available commands: 'new', 'difficulty', or 'exit'"
    action = gets.chomp!
    user_response(action)
  end

  def user_response(action)
    bingo_str = "bingo"
    if action == "new"
      new_game
    elsif action == "difficulty"
      puts "Please choose a difficulty *easy *normal *hard *impossible(you have to be very lucky to win this)"
      action = gets.chomp!.downcase
      @difficulty = 
      if action == "easy"
        5
      elsif action == "normal"
        10
      elsif action == "hard"
        20
      elsif action == "impossible"
        40
      else
        puts "You didn't choose a correct difficilty. Let's try easy"
        5
      end
      user_action?
    elsif bingo_str.include?(action.downcase) && action != "" #intereting... "" returns true for #include?
      letter = action
      puts "Please tell me a number between 1-75"
      number = gets.chomp!.to_i
      until number > 0 && number < 76
        puts "Please enter a valid number between 1-75"
        number = gets.chomp!.to_i
      end
        call(letter, number)
    elsif action == "exit" 
      abort("
        ByeBye~Thanks for playing T^T")
    else
      puts "Please input a valid entry"
      user_action?
    end
  end

  def call(letter, number)
    if rand(1..100) < @difficulty
      puts $event_list[rand(0..($event_list.size - 1))]
      return new_game
    end
    @count += 1
    puts "
    Round #{@count}"
    @bingo_board.each {|x| x[letter_to_index(letter)] = "X" if x[letter_to_index(letter)] == number}
    check_hor
    check_vert
    check_diag
    win?
    @bingo_board.each {|row| p row}
    user_action?
  end
  
  def letter_to_index(letter)
    letter.downcase!
    if letter == "b"
      0
    elsif letter == "i"
      1
    elsif letter == "n"
      2
    elsif letter == "g"
      3
    elsif letter == "o"
      4
    else
      raise ArgumentError.new("Invalid Argument. Please input any letters from the word 'bingo'")
    end
  end

  def check_hor
    i = 0
    while i < @bingo_board.length 
      @win = true if @bingo_board[i].count("X") == 5
      i += 1
    end  
  end

  def check_vert
    transpose_board
    check_hor
    transpose_board
  end

  def check_diag
    check_diag_helper
    reverse_board
    check_diag_helper
    reverse_board
  end

  def check_diag_helper
    @win = true if [@bingo_board[0][0], @bingo_board[1][1], @bingo_board[3][3], @bingo_board[4][4]].all? {|element| element == "X"}    
  end

  def win?
    puts "
    lollollol>>>Hey, you won!<<<lollollol ---- Start another new game? 
    " if @win == true
  end

  def transpose_board
    @bingo_board = @bingo_board.transpose
  end

  def reverse_board
    @bingo_board.reverse!
  end
end

# run the game!
BingoBoard.new.user_action?


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

