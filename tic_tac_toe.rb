# class for game board with methods to update cell/board
class Board
  attr_reader :cell, :board

  WINNING_COMBO = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def initialize
    @cell = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def update_board(_board = @cell)
    puts "\n
           #{cell[0]} | #{cell[1]} | #{cell[2]} \n
          -----------
           #{cell[3]} | #{cell[4]} | #{cell[5]} \n
          -----------
           #{cell[6]} | #{cell[7]} | #{cell[8]}"
  end

  def cell_update(number, marker)
    @cell[number - 1] = marker
  end
end

# class for the current game session
class Game
  attr_reader :firstplayer_turn, :current_board

  def initialize
    @firstplayer_turn = nil
    @current_board = Board.new
    @winner = nil
  end

  def play
    # initialize game?
    start_game
    # gaming
    gaming
    # result
    declare_result
    # replay?
    menu
  end

  def menu
    puts 'Hello there, care for a game of Tic-Tac-Toe?(y/n)'
    stuck_in_menu = true
    while stuck_in_menu == true
      input = gets.chomp.downcase
      if input == 'y'
        stuck_in_menu = false
        play
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
        puts 'Player 2, please choose a valid spot to place your marker (O).'
        o_marker = gets.chomp.to_i
        o_marker = input_check(o_marker)
        @current_board.cell_update(o_marker, 'O')
        @firstplayer_turn = true
      end
      @current_board.update_board(@current_board.cell)
      match_over = true if check_board_full? || winner_exist?
    end
  end

  def input_check(input)
    until (1..9).include?(input) && valid_space_check(input)
      puts 'Please enter a valid input!(1-9)'
      puts 'Makes sure the spot is not occupied.'
      input = gets.chomp.to_i
    end
    input
  end

  def valid_space_check(input)
    @current_board.cell.each_with_index do |cell, index|
      return true if index == input - 1 && (cell == index - 1)
      return false if index == input - 1 && %w[X O].include?(cell)
    end
  end

  def winner_exist?
    # check if any winning combo exist
    Board::WINNING_COMBO.any? do |combo|
      [@current_board.cell[combo[0]],
       @current_board.cell[combo[1]],
       @current_board.cell[combo[2]]].uniq.length == 1
    end
  end

  def declare_result
    if winner_exist?
      @winner = firstplayer_turn == true ? 'O' : 'X'
      case @winner
      when 'X'
        puts 'Congratualtions, player 1! You Won!'
      when 'O'
        puts 'Congratulations, player 2! You Won!'
      end
    elsif check_board_full?
      puts "It's a TIE! The board is full and no more move can be made!"
    end
    puts "Press enter to return to menu."
    gets
  end

  def check_board_full?
    return true unless @current_board.cell.any? { |cell| cell.is_a? Numeric }
  end
end
new_game = Game.new
new_game.menu
