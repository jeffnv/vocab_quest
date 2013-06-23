require './word_mgr'
require './games'
WORDS_DIR = "words"
@word_mgr


def get_files
  Dir.entries(WORDS_DIR).select{|file| !file.start_with?'.'}
end

def select_file
  files = get_files
  result = show_menu(files)
  if(result < files.count)
    @word_mgr.load_words("#{WORDS_DIR}/#{files[result]}")
  end
end

def show_menu (choices, instruction = "")
  instruction  = "Please enter the number of your choice." if instruction.empty?
  message = ""
  done = false
  choices << "exit"
  result = 0
  
  until done do
    # system("clear")
    puts "\n"
    puts message unless message.empty?
    puts instruction
    
    choices.each_with_index do |item, index|
      puts "  #{index + 1}. #{item}"
    end
    
    choice = gets.chomp.to_i - 1
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

def main_menu
  choices = ["load words", "match words to definitions"]
  
  choice = -1
  while choice != choices.count do
    choice = show_menu(choices)
    
    case choice
    when 0
      select_file
    when 1
      puts "not yet..."
    end
  end
end


@word_mgr = WordMgr.new
puts "Welcome to the quest!"
main_menu
puts "bye!"
