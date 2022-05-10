

class TicTacToe
  attr_reader :game_over
  attr_reader :turn
  def initialize()
    @grid = Array.new(9)
    @turn = 'x'
    @cats_game = false
  end
  def check_if_won
    # check horizontal
    for i in 0...3
      t = @grid[i * 3]
      next unless t
      section = @grid.slice(i * 3, i * 3 + 3)
      if section.compact.length == 3 && section.compact.all?{ |e| e == t }
        return t
      end
    end
    # check vertical
    for i in 0...3
      next unless @grid[i]
      if @grid[i] == @grid[i + 3] && @grid[i + 3] == @grid[i + 6]
        return @grid[i]
      end
    end
    # check diagonal
    if @grid[0] && @grid[0] == @grid[4] && @grid[4] == @grid[8]
      return @grid[0]
    end
    if @grid[2] && @grid[2] == @grid[4] && @grid[4] == @grid[6]
      return @grid[2]
    end

    # check no winner
    if @grid.compact.length == 9
      return "c"
    end
    
    false
  end
  def make_move(move)
    return if @game_over
    if move < 1 || move > 9
      return puts "Please make move between 1 and 9"
    end
    if @grid[move - 1]
      return puts "Square taken"
    end
    @grid[move - 1] = @turn
    won = check_if_won
    if won
      game_over_message
      @cats_game = true if won == 'c'
      return @game_over = true
    end
    @turn = (@turn == 'x' ? 'o' : 'x')
  end
  def game_over_message
    puts @cats_game ? "Cat's game! " : @turn + " wins!"
  end
  def print_game
    str = ""
    @grid.each_with_index do |t, i|
      if i == 3 || i == 6
        str += "-----\n"
      end
      str += (t ? t : " ")
      str += (i % 3 == 2 ? "\n" : "|")
    end
    puts str
    str
  end
  def legal_moves
    @grid.each_with_index.map{ |s, i| s ? nil : i + 1 }.compact
  end
end





class Game
  def initialize()
    @game = TicTacToe.new
  end
  def begin
    type = ''
    while true
      puts "Would you like to be x or o? Type 'x' or 'o'"
      type = gets.chomp.downcase
      if(type.length > 1 || !type.match(/x|o/))
        puts 'That is an invalid response'
      else
        puts "You: #{type}\nComputer: #{type == 'x' ? 'o' : 'X'}"
        break
      end
    end
    while true
      break if @game.game_over
      if @game.turn == type
        puts "Your turn"
        puts "Make a move: input a number between 1 and 9"
        move = gets.chomp.to_i
        @game.make_move(move)
      else
        puts "Computer's turn"
        make_move
      end
      @game.print_game
    end
  end
  def make_move
    @game.make_move(@game.legal_moves.sample)
  end
end

game = Game.new
game.begin