scores_hash = {
  "A" => 'Rock',
  "B" => 'Paper',
  "C" => 'Scissors',
  "Y" => ['Paper', 2],
  "X" => ['Rock', 1],
  "Z" => ['Scissors', 3],
}

# tie is 3 points / win is 6 points / loss is 0 points

class Game
    attr_accessor :elf_choice
    attr_reader :player_choice

# attr_reader I want to read the instance variable
# attr_writer I want to assign the instance variable
# attr_accessor I want to read and assign the instance variable

    def initialize(elf_choice, player_choice)
        self.elf_choice = elf_choice
        @player_choice = player_choice
    end
 
    # # def elf_choice
    # #     @elf_choice
    # # end

    # # def player_choice
    # #     @player_choice
    # # end

    def player_choice
        @player_choice[0]
    end

    def player_score
        @player_choice[1]
    end

    def score
        # homework remove some of the elsifs 
        # homework refactor this into a swtich statement
        if self.elf_choice == 'Rock' && self.player_choice == 'Paper'
          return self.player_score + 6
        elsif self.elf_choice == 'Paper' && self.player_choice == 'Scissors'
            return self.player_score + 6
        elsif self.elf_choice == 'Scissors' && self.player_choice == 'Rock'
            return self.player_score + 6
        elsif self.elf_choice == self.player_choice 
            return self.player_score + 3
        end

        return player_score
    end
end
# Intialize is accepting params., we can then use those param to assign memory to an instance variable

games = []

File.read('day2input.txt').split.each_slice(2) do |(elf, player)| 
    games.push Game.new(scores_hash[elf], scores_hash[player])
end

total = games.reduce(0) do |sum, game|
    sum += game.score
end
puts total

# Access the file data and input it into our game logic
# Add the total of all scores for all the games