class Mastermind
    COLOURS = %w[RED BLUE GREEN YELLOW BLACK WHITE]
    MAX_GUESSES = 12
    attr_accessor :code, :guesses, :guess_array
    def initialize(human_player, computer_player)
        @code = []
        @guesses = 0
        @guess_array = []
        initialize_roles(human_player, computer_player)
    end
    def initialize_roles(human_player, computer_player)
        choices = ['1','2']
        choice = 0
        while !choices.include?(choice)
            puts "Please enter 1 if you want to be code maker or 2 if you want to be code breaker"
            choice = gets.chomp
            if choice == '1'
                @codemaker = human_player
                @codebreaker = computer_player
            elsif choice == '2'
                @codemaker = computer_player
                @codebreaker = human_player
            else
                puts "Invalid choice. Please enter 1 or 2."
            end
        end
    end
    def play_game
        code = @codemaker.generate_code
        until guesses>=MAX_GUESSES
            guess_array = @codebreaker.enter_code(code)
            show_results(guess_array, code)
            @guesses += 1
            if guess_array == code
                puts "Congratulations! You guessed the code correctly in #{@guesses} guesses."
                break
            end
        end
        if guess_array != code
            puts "Sorry, you've reached the maximum number of guesses. The secret code was: #{code.join(', ')}"
        end
    end
    def show_results(guess_array, code)
        secret_code = code.dup
        copy_guess = guess_array.dup
        puts "Your guess is: #{guess_array}"
        copy_guess.each_with_index do |guess, index|
            if guess == secret_code[index]
                puts "#{guess} is found at the correct poisition."
                secret_code[index] = nil
                copy_guess[index] = nil
            end
        end
        copy_guess.each_with_index do |guess, index|
            next if guess.nil?
            if secret_code.include?(guess)
                puts "#{guess} is found at the wrong position."
                secret_code[secret_code.index(guess)] = nil
            else
                puts "#{guess} is not found."
            end
        end
    end
end

class Player
    attr_accessor :guess_array
end

class HumanPlayer < Player
    def generate_code
        puts Mastermind::COLOURS
        loop do
            puts "Please enter your code in the form of: colour, colour, colour, colour"
            code = gets.chomp.split(", ")
            are_valid_colors = code.all? { |col| Mastermind::COLOURS.include?(col) }
            return code if are_valid_colors
        end
    end
    def enter_code(code)
        puts Mastermind::COLOURS
        puts "Please enter your guess in the form of: colour, colour, colour, colour"
        code = gets.chomp.split(", ")
        return code
    end
end

class ComputerPlayer < Player
    def initialize
        super
        @best_guess = Array.new(4, nil)
    end
    def generate_code
        return Array.new(4) {Mastermind::COLOURS.sample}
    end
    def enter_code(code)
        @guess_array = generate_code    
        guess_array.each_with_index do |g, i|
          @best_guess[i] = g if code.include?(g) && code[i] == g
        end
    
        puts '--------- Current best guess value ---------'
        puts @best_guess
        return @best_guess
      end
end

human_player = HumanPlayer.new
computer_player = ComputerPlayer.new
mastermind = Mastermind.new(human_player, computer_player)
mastermind.play_game