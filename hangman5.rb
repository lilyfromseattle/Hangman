require 'colorize'

class Hangman
  attr_accessor :word
  def initialize(word)
    @word = word
    @word_array = []
    @spaces = Array.new(@word.length, "_")
    @guesses = []
    @wrong_guesses = []
    @line1 = "_____"
    @line2 = "|/  |"
    @line3 = "|   "
    @line4 = "|  "
    @line5 = "|  "
    @line6 = "|_______"
  end

  def start_game
    puts "Welcome to Hangman!"
    while @line5 != "| / \\"
      if @wrong_guesses.length >= 6
        you_lose
      elsif @spaces.join == @word.downcase
        you_win
      end
      print_board
      print_word
      print_guesses
      puts "Enter your guess:"
      guess = gets.chomp
      puts ""
        if guess == "exit" or guess == "Exit"
          puts "Thanks for playing!"
          puts ""
          exit(0)
        end
      validate_guess(guess)
    end
  end

  def you_win
    puts "You win!"
    puts "The word was '#{word}'!"
    puts "Thanks for playing!"
    exit(0)
  end

  def you_lose
    puts "You lose!"
    puts "The word was '#{word}'!"
    puts "Thanks for playing!"
    exit(0)
  end

  def validate_guess(a_guess)
    for letter in @guesses
      if a_guess.downcase == letter.downcase
            puts "You already guessed that letter!"
      end
    end
        if a_guess.alpha? == false
          puts "Thats not a letter!"
        elsif a_guess.alpha? and a_guess.length > 1 and a_guess.downcase != @word.downcase
          puts "That's not the word!"
        elsif
          a_guess.downcase == @word.downcase
            you_win
        else
          count = 0
          @word_array = @word.split(//)
              for letter in @word_array
                if letter.downcase == a_guess.downcase
                  @spaces[@word_array.index(letter)] = letter.downcase
                  count = count + 1
                end
              end
          add_to_guesses(a_guess)
          hang(count, a_guess)

        end
  end

  def print_board
    puts @line1
    puts @line2
    puts @line3
    puts @line4
    puts @line5
    puts @line6
  end

  def print_guesses
    puts "Already Guessed:"
    puts @guesses.to_s
  end

  def add_to_guesses(your_guess)
    @guesses << your_guess
  end

  def print_word
    puts @spaces.join
  end


  def hang(lettercount, someguess)
    if lettercount == 0
      @wrong_guesses << someguess
      puts "Sorry, that letter isn't in the word!"
      if @wrong_guesses.length == 1
        @line3 << "O".colorize(:red)
      elsif @wrong_guesses.length == 2
        @line4 << "/".colorize(:orange)
      elsif @wrong_guesses.length == 3
        @line4 << "|".colorize(:yellow)
      elsif @wrong_guesses.length == 4
        @line4 << "\\".colorize(:green)
      elsif @wrong_guesses.length == 5
        @line5 << "/ ".colorize(:blue)
      elsif @wrong_guesses.length == 6
        @line5 << "\\".colorize(:purple)
      end
    end
  end
end

class String
  def alpha?
    !!match(/^[[:alpha:]]+$/)
  end
end

wordarray = ["Kitten", "Mailbox", "Library", "Laptop", "Dinosaur", "Ghost", "Alpaca", "Cheesecake", "Pumpkin", "Pineapple", "Mitten", "Bulldozer", "Popcorn", "Skyscraper"]
my_game = Hangman.new(wordarray[rand(wordarray.length - 1)])


my_game.start_game
