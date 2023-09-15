require_relative 'game'

def start_game
    puts "Hangman. Would you like to: 1) Start a new game"
    puts "                            2) Load a game"
    user_choice = gets.chomp
    puts
    until ['1', '2'].include?(user_choice)
        puts "Invalid input. Please enter 1 or 2"
        user_choice = gets.chomp
    end
    if user_choice == '1'
        game = Game.new
        game.play_game
    else
        game = Game.new
        game.load_game
    end
end

start_game
