# class for game board with methods to update cell/board
class Board
  attr_reader :cell, :board

  def initialize
    @cell = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = [[@cell[0], @cell[1], @cell[2]], [@cell[3], @cell[4], @cell[5]], [@cell[6], @cell[7], @cell[8]]]
  end

  def update_board(board = @board)
    puts "\n
           #{board[0][0]} | #{board[0][1]} | #{board[0][2]} \n
          -----------
           #{board[1][0]} | #{board[1][1]} | #{board[1][2]} \n
          -----------
           #{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
  end

  def cell_update(number, marker)
    @cell[number - 1] = marker
    @board = [[@cell[0], @cell[1], @cell[2]], [@cell[3], @cell[4], @cell[5]], [@cell[6], @cell[7], @cell[8]]]
  end
end

# class for the current game session
class Game
  attr_reader :firstplayer_turn, :current_board

  def initialize
    @firstplayer_turn = nil
    @current_board = Board.new
  end

  def play
    # menu
    menu
    # initialize game?
    start_game
    # gaming
    gaming
    # result
    # replay?
  end

  def menu
    puts 'Hello there, care for a game of Tic-Tac-Toe?(y/n)'
    stuck_in_menu = true
    while stuck_in_menu == true
      input = gets.chomp.downcase
      if input == 'y'
        stuck_in_menu = false
      elsif input == 'n'
        stuck_in_menu = false
        puts 'Alright, see you around!'
      else
        puts 'Please enter something valid!'
        next
      end
    end
  end

  def start_game
    puts "RNGsus rolled a #{rng = Random.rand(1..2)}"
    if rng == 1
      puts 'RNGsus decided that player 1 goes first!'
      @firstplayer_turn = true
    else
      puts 'RNGsus decided that player 2 goes first!'
      @firstplayer_turn = false
    end
  end

  def gaming
    match_over = false
    puts 'See the board below? The position is labelld with numbers as shown.'
    puts 'When inputting your next move, use the numbers to refer to the position of your choice!(1-9)'
    @current_board.update_board
    puts @firstplayer_turn
    until match_over == true
      case @firstplayer_turn
      when true
        # make a move => check validity => update_board => check who win/tie => switch player
        puts 'Player 1, please choose a valid spot to place your marker (X).'
        x_marker = gets.chomp.to_i
        x_marker = input_check(x_marker)
        @current_board.cell_update(x_marker, 'X')
        @firstplayer_turn = false
      when false
        puts 'yo'
        @firstplayer_turn = true
      end
      next
    end
  end

  def input_check(input)
    until (1..9).include?(input) && valid_space_check(input)
      puts 'Please enter a valid input!(1-9)'
      puts 'Makes sure the spot is not occupied.'
      puts input
      input = gets.chomp.to_i
    end
    puts "valid input is #{input}"
    input
  end

  def valid_space_check(input)
    @current_board.cell.each_with_index do |cell, index|
      return true if index == input - 1 && (cell == index - 1)
    end
  end

  def three_equal?(a, b, c)
    # check if the three cells are equal, determine winner base on X or O
  end

  def check_winner
    # equal
  end
end
new_game = Game.new
new_game.play
