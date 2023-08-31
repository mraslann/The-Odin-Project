class TicTacToe
    WINS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    def initialize(player_1_class, player_2_class)
        @board = Array.new(10)
        @player_1 = player_1_class.new(self, "X")
        @player_2 = player_2_class.new(self,"O")
        @current_player = @player_1
    end
    attr_reader :board , :current_player
    def board
        @board[1..9]
    end
    def switch_players
        @current_player = @current_player == @player_1 ? @player_2 : @player_1
    end
    def make_move(position)
        @board[position] = @current_player.symbol
    end
    def display_board
        puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
        puts "---+---+---"
        puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
        puts "---+---+---"
        puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "
    end
    def check_winner
        WINS.any? do |win_combinations|
            win_combinations.all? {|position| @board[position] == current_player.symbol}
        end
    end
    def check_draw
        @board[1..9].all? {|cell| cell.is_a?(String)}
    end
    def play
        loop do
            display_board
            puts "#{current_player.symbol}'s turn. Enter a position (1-9): "
            position = gets.chomp.to_i
            if position.between?(1,9) && @board[position].nil?
                make_move(position)
            else
                puts "Invalid move. Please try again"
                next
            end
            if check_winner
                display_board
                puts "#{current_player.symbol} wins!"
                break
            elsif check_draw
                display_board
                puts "It's a draw!"
                break
            end
            switch_players
        end
    end
end

class Player
    attr_reader :symbol
    def initialize(game, symbol)
        @game = game
        @symbol = symbol
    end
end

class HumanPlayer < Player
end

class ComputerPlayer < Player
end

game = TicTacToe.new(HumanPlayer, ComputerPlayer)
game.play