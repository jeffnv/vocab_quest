require './lib/word_mgr'
require './lib/games'
require './lib/feedback_mgr'
require 'io/console'
require './lib/os_finder.rb'
#include OS
WORDS_DIR = "words"
FEEDBACK_DIR = "etc"
STATE_DIR = "lib"
@word_mgr
@feedback_mgr


def set_up_screen_variable
  if OS.unix? 
    $clear = 'clear'
  else #windows
    $clear = 'cls'
  end
end

def get_files
  Dir.entries(WORDS_DIR).select{|file| !file.start_with?'.'}
end

def pause
  puts "\n\npress any key to continue"
  STDIN.getch
end


def show_menu (choices, instruction = "")
  instruction  = "Please enter the number of your choice." if instruction.empty?
  message = ""
  done = false
  choices << "exit"
  result = 0
  
  until done do
    system($clear)
    puts "\n"
    puts message unless message.empty?
    puts instruction
    
    choices.each_with_index do |item, index|
      puts "  #{index + 1}. #{item}"
    end
    
    if(choices.count < 10)
      choice = STDIN.getch.to_i - 1
    else
       choice = gets.chomp.to_i - 1
    end
    
    if(choice >= 0 && choice < choices.count)
      result = choice
      done = true
    else
      #choice was invalid
      message = "invalid selection!"
    end
  end
  puts "you chose: #{choices[result]}"
  choices.pop
  result
end

def refresh_message
  message = "Welcome to Vocab Quest\n"
  if(@word_mgr.groups.count > 0)
    message << "\nCurrently using: " + @word_mgr.groups.inject("") {|res, group| res << "#{group}, "}[0..-3]
  else
    message << "\n***No words loaded, please start by selecting a deck!!!***\n"
  end
  
  message << "\nPlease select an option."
  message
end

def select_file
  files = get_files
  result = show_menu(files)
  if(result < files.count)
    @word_mgr.load_words("#{WORDS_DIR}/#{files[result]}")
  end
end

def show_missed_history
  system($clear)
  puts "Most Frequently Missed Words"
  puts "Word                Miss Count"
  @word_mgr.missed.each do |entry, miss_count|
    puts "#{entry[0]}".ljust(15) + miss_count.to_s.rjust(15)
  end
end

def history
  options = ["Show most frequently missed words", "generate list of missed words", "reset missed words"]
  result = -1
  while result!= options.count do
    result = show_menu(options)
    case result
    when 0
      show_missed_history
    when 1
      @word_mgr.generate_missed_word_list(WORDS_DIR)
    when 2
      if (show_menu(["yes"], "Permanetly reset missed words list?") == 0) 
        @word_mgr.reset_missed 
        puts "missed history reset"
      end
    end
    pause
  end
  
end

def main_menu
  choices = ["match words to definitions", "flash cards","select deck", "history"]

  choice = -1
  while choice != choices.count do
    choice = show_menu(choices, refresh_message)
    case choice
    when 0
      WordMatchDef.new(@word_mgr, @feedback_mgr).play
    when 1
      FlashCards.new(@word_mgr, @feedback_mgr).play
    when 2
      select_file
    when 3
      history
    end
  end
  
  @word_mgr.save
end

set_up_screen_variable
system($clear)
@word_mgr = WordMgr.new(STATE_DIR)
@feedback_mgr = FeedbackMgr.new(FEEDBACK_DIR)
main_menu
puts "bye!"
system($clear)
