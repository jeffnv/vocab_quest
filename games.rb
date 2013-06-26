require 'io/console'

class Game
  def initialize(words)
    @word_mgr = words
  end
  
  def play 
    puts 'weeeee'
  end
end

class FlashCards < Game
  
  def flash
    input = ''
    while !input.downcase.start_with? 'q' do
      entry = @word_mgr.rand_entry
      puts "\n\n'#{entry[0]}'"
      return if(STDIN.getch.downcase.start_with? 'q')
      puts "\n\n#{entry[1]}"
      
      puts "\n\nDid you know it?"
      done = false
      until done do
        input = STDIN.getch
        if(input.downcase.start_with? 'y')
          puts "Well done!"
          @word_mgr.matched(entry[0])
          done = true
        elsif(input.downcase.start_with? 'n')
          puts "oh."
          done = true
        elsif(input.downcase.start_with? 'q')
          done = true
        else
          puts "Please enter 'y' or 'n' to tell me if you got it or not. Enter 'q' to quit."
        end
      end
    end
  end
  
  def play
    puts "Welcome to Flash Cards!\n\tA word will be shown, press enter to see the definition. 
    Enter 'y' or 'n' to tell the game whether you knew it or not. Enter 'q' at any time to quit.
    
    Press any key to begin!"
    input = STDIN.getch
    flash
  end
  
  
end

class WordMatchDef < Game
  NUM_FAKE_DEFS = 4
  def match
    fake_defs = []
    entry = @word_mgr.rand_entry
    fake_defs = @word_mgr.rand_def(NUM_FAKE_DEFS)
    defs = fake_defs << entry[1]
    defs.shuffle!
    
    puts "\n\n ''#{entry[0]}''\n"
    str = ""
    defs.each_with_index do |definition, index|
      str << "  #{index + 1}. #{definition}\n"
    end
    puts str + "Enter matching number and press enter:"
    guess = gets.chomp.to_i - 1
    
    if(defs[guess] == entry[1])
      puts "\n\nAWW YISS!\n\n"
      correct = true
      @word_mgr.matched(entry[0])
    else
      puts "\n\noops. I'm sure you meant: #{entry[1]}\n\n"
      correct = false
    end
    return correct
  end
  
  def play
    puts "How many rounds?"
    score = 0
    @rounds = gets.chomp.to_i
    @rounds.times do
      score += 1 if match
    end
  end
end