require 'io/console'

class Game
  def initialize(words, feedback)
    @word_mgr = words
    @feedback_mgr = feedback
  end
  def reset
  end
  def play 
    puts 'weeeee'
  end
  
  def get_input(options, message)
    done = false
    puts message
    until done do
      input = STDIN.getch
      if(options.include?(input.downcase[0]))
        done = true
      else
        puts message
      end
    end
    input
  end
  
  def offer_reset
    message =  "\n\nYou have gotten all the words! Reset or quit? Enter 'r' or 'q'"
    opts = %w(r q)
    get_input(opts, message) == 'r'
    
  end
  
  def get_entry
    entry = nil
    if @word_mgr.words.empty?
      if offer_reset
        @word_mgr.reset_words
        entry = @word_mgr.rand_entry
      end
    else
      entry = @word_mgr.rand_entry
    end
    entry
  end
  
end

class FlashCards < Game
  def flash
    feedback = ''
    input = ''
    while !input.downcase.start_with? 'q' do
      
      entry = get_entry
      return if entry == nil
      system("clear")
      puts "#{feedback}\n\n'#{entry[0]}'"
      return if(STDIN.getch.downcase.start_with? 'q')
      puts "\n\n#{entry[1]}"
      
      puts "\n\nDid you know it?"
      done = false
      until done do
        input = STDIN.getch
        if(input.downcase.start_with? 'y')
          feedback =  @feedback_mgr.yes
          @word_mgr.match(entry[0])
          done = true
        elsif(input.downcase.start_with? 'n')
          feedback = @feedback_mgr.no
          @word_mgr.miss(entry[0])
          done = true
        elsif(input.downcase.start_with? 'q')
          done = true
        else
          feedback = "Please enter 'y' or 'n' to tell me if you got it or not. Enter 'q' to quit."
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
    feedback = ''
    @rounds.times do
      entry = get_entry
      return if entry == nil
    
      fake_defs = @word_mgr.rand_def(NUM_FAKE_DEFS)
      defs = fake_defs << entry[1]
      defs.shuffle!
      system("clear")
      puts "#{feedback}\n\n ''#{entry[0]}''\n\n"
      str = ""
      defs.each_with_index do |definition, index|
        str << "  #{index + 1}. #{definition}\n"
      end
      puts str + "\nEnter matching number and press enter:"
      guess = STDIN.getch.chomp.to_i - 1
    
      if(defs[guess] == entry[1])
        feedback =  "\n\n#{@feedback_mgr.yes}\n\n"
        @word_mgr.match(entry[0])
      else
        feedback =  "\n\n#{@feedback_mgr.no}\nI'm sure you meant: #{entry[1]}\n\n"
        @word_mgr.miss(entry[0])
      end
    end
  end
  
  def play
    puts "How many rounds?"
    @rounds = gets.chomp.to_i
    match
  end
end