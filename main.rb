require './player'

class Game
  def initialize
    @players = []
    @current_player_index = 0
    @game_over = false
    @questions = []
    (1..20).each do |num1|
      (1..20).each do |num2|
        @questions << "#{num1} + #{num2}"
      end
    end
    @questions.shuffle!
  end

  def add_player(player)
    @players << player
  end

  def next_player
    @current_player_index = (@current_player_index + 1) % @players.length
  end

  def current_player
    @players[@current_player_index]
  end

  def game_over?
    @game_over
  end

  def ask_question
    question = @questions.pop
    puts "#{current_player.name}: #{question}"
    answer = gets.chomp.to_i
    if answer == eval(question.split('=')[0])
      puts "YES! You are correct!"
    else
      puts "Seriously? No! #{current_player.name} loses a life."
      current_player.lose_life
    end

    if current_player.dead?
      puts "#{current_player.name} is out of the game."
      @players.delete_at(@current_player_index)
      @current_player_index -= 1
      if @players.length == 1
        puts "#{current_player.name} wins with #{current_player.lives} lives remaining!"
        @game_over = true
      end
    end
  end

  def play
    puts "Welcome to the Math Game!"
    @players.each { |player| puts "#{player.name} has #{player.lives} lives." }
    puts "Let's start!"
    while !game_over?
      ask_question
      next_player
    end
  end
end

# Example usage:
game = Game.new
game.add_player(Player.new("Player 1"))
game.add_player(Player.new("Player 2"))
game.play
