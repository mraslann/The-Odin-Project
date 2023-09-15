require 'yaml'

class Game
    def initialize
        @word = generate_word
        @incorrect_letters = []
        @guesses = 10
        @displayed_word = Array.new(@word.length, "_").join("")
    end

    def generate_word
        dictionary = File.open("google-10000-english-no-swears.txt", "r") 
        words = []
        dictionary.each do |word|
            if word.length <= 12 && word.length >= 5
                words.append(word)
            end
        end
        dictionary.close
        words.sample.chomp.downcase
    end

    def draw_stickman(guesses_left)
        stickman = [
          "   ____",
          "  |    |",
          "  |",
          "  |",
          "  |",
          "  |",
          " _|_"
        ]
    
        case guesses_left
            when 9
                stickman[2] = "  |    O"
            when 8
                stickman[2] = "  |    O"
                stickman[3] = "  |    |"
            when 7
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|"
            when 6
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
            when 5
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   /"
            when 4
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   / \\"
            when 3
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   / \\"
                stickman[6] = "_|_   DEAD"
            when 2
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   / \\"
                stickman[6] = "_|_   DEAD"
                stickman[1] = "  |    |"
            when 1
                stickman[2] = "  |    O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   / \\"
                stickman[6] = "_|_   DEAD"
                stickman[1] = "  |   /|"
            when 0
                stickman[2] = "  |   -O"
                stickman[3] = "  |   /|\\"
                stickman[4] = "  |   / \\"
                stickman[6] = "_|_   DEAD"
                stickman[1] = "  |   /|\\"
        end
        puts stickman
    end

    def guess_letter
        puts "Please enter a letter or 'save' to save your progress."
        guessed_letter = gets.chomp.downcase
        if guessed_letter == 'save' 
            return guessed_letter
        end
        while !guessed_letter.match?(/^[a-zA-Z]$/)
            puts "Invalid guess. Please enter a letter."
            guessed_letter = gets.chomp.downcase
        end
        guessed_letter
    end

    def save_game
        Dir.mkdir('output') unless Dir.exist?('output')
        filename = "#{@displayed_word}.yaml"
        File.open("output/#{filename}", "w") do |file|
            file.write(save_game_state)
        end
        puts "Your game has been saved successfully at output/#{filename}."
    end
    
    def save_game_state
        YAML.dump('word' => @word,
            'incorrect_letters' => @incorrect_letters,
            'guesses' => @guesses,
            'displayed_word' => @displayed_word
        )
    end

    def load_game
        saved_games = Dir.glob("output/*.yaml").map { |filename| File.basename(filename, ".yaml") }
        if saved_games.empty?
            puts "No saved games found."
            return
        end
        puts "Choose a saved game to load:"
        saved_games.each_with_index { |game, index| puts "#{index + 1}. #{game}" }
        selection = gets.chomp.to_i
        if selection >= 1 && selection <= saved_games.length
            selected_game = saved_games[selection - 1]
            filename = "output/#{selected_game}.yaml"
            saved_data = YAML.load_file(filename)
            # Update game state with loaded data
            @word = saved_data['word']
            @incorrect_letters = saved_data['incorrect_letters']
            @guesses = saved_data['guesses']
            @displayed_word = saved_data['displayed_word']
            puts "Game '#{selected_game}' loaded successfully!"
            play_game # Resume the game
        else
            puts "Invalid selection."
        end
    end
      
    def play_game
        while @guesses > 0
            puts @displayed_word
            draw_stickman(@guesses)
            puts "Your incorrect guesses: #{@incorrect_letters.join(" ")}"
            guessed_letter = guess_letter
            if guessed_letter == 'save'
                save_game
                break
            end
            if @displayed_word.include?(guessed_letter) || @incorrect_letters.include?(guessed_letter)
                puts "You already guessed #{guessed_letter}. Try again!"
            elsif @word.include?(guessed_letter)
                @word.length.times do |i|
                    if @word[i] == guessed_letter
                        @displayed_word[i] = guessed_letter
                    end
                end
            else
                puts "You incorrectly guessed #{guessed_letter}"
                @guesses -= 1
                @incorrect_letters.append(guessed_letter)
            end
            if @displayed_word == @word
                puts "Congratulations. You won! The word was #{@word}."
                break
            end
        end
        if @displayed_word != @word && @guesses == 0
            puts "Oh no. You lost :(. The correct word was #{@word}."
            draw_stickman(0)
        end
    end
end