class Player
  attr_accessor :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

end

class Board
  attr_accessor :arr
  
  def initialize
    @arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display
    puts "=============",
         "| #{@arr[0]} | #{@arr[1]} | #{@arr[2]} |",
         "-------------",
         "| #{@arr[3]} | #{@arr[4]} | #{@arr[5]} |",
         "-------------",
         "| #{@arr[6]} | #{@arr[7]} | #{@arr[8]} |",
         "============="
  end

end

class Game

  def initialize
    setup_players
    display_instructions
    clear_board
    play
  end

  def clear_board
    @board.arr.map! { |i| i = ' ' }
  end

  def setup_players
    puts "Enter a name for Player 1:"
    @player_x = Player.new(gets.chomp.capitalize, "X")
    puts "Greetings, #{@player_x.name}. You will be playing as 'X'."
    puts "Enter a name for Player 2:"
    @player_o = Player.new(gets.chomp.capitalize, "O")
    puts "Greetings, #{@player_o.name}. You will be playing as 'O'."
    @current_player = @player_x
  end

  def display_instructions
    puts "Choose a position by entering a number (1-9)."
    @board = Board.new
    @board.display
    puts "#{@player_x.name}, you will go first. Choose a position:"
  end

  def play
    player_turn
    update_board
    @board.display
    check_for_win
    check_for_draw
    switch_players
    puts "Now it's #{@current_player.name}'s turn. Choose a position:"
    play
  end

  def player_turn
    @choice = Integer(gets) rescue false
    # validate choice (must be Int, must not be out of range, must not be occupied)
    if @choice == false || @choice >= 10 || @choice <= 0 || @board.arr[@choice-1] != ' '
      puts "Please enter the number of an available position:"
      player_turn
    else 
      puts "#{@current_player.name} placed an #{@current_player.piece} in space #{@choice}."
    end
  end

  def switch_players
    if @current_player == @player_x
      @current_player = @player_o
    else
      @current_player = @player_x
    end
  end

  def update_board
    @board.arr[@choice-1] = @current_player.piece
  end

  def check_for_win
    if winning_combo? == true
      puts "\n#{@current_player.name.upcase} WINS!!"
      puts "\nWould you like to play again? y/n"
      response = gets.chomp.downcase
      if response != 'y'
        end_game
      else
        Game.new
      end
    end
  end

  def check_for_draw
    if board_full? == true
      puts "\nIt's a draw."
      puts "\nWould you like to play again? y/n"
      response = gets.chomp.downcase
      if response != 'y'
        end_game
      else
        Game.new
      end
    end
  end

  def winning_combo?
    @wins = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]
    # winning combos match index of player pieces?
    if @wins.any? { |combo| combo.all? { |idx| @board.arr[idx] == @current_player.piece } }
      true
    end
  end

  def board_full?
    if @board.arr.all? { |i| i != ' '}
      true
    end
  end

  def end_game
    puts "Goodbye!"
    exit!
  end
end
    
Game.new