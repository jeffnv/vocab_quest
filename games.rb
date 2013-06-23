class Game
  def initialize(words)
    @word_mgr = words
  end
  
end

class WordMatchDef < Game
  def match
    fake_defs = []
    entry = @word_mgr.rand_entry
    4.times{fake_defs << @word_mgr.rand_def}
    defs = fake_defs << entry[1]
    defs.shuffle!
    
    puts entry[0]
    str = ""
    defs.each_with_index do |definition, index|
      str << "  #{index + 1}. #{definition}\n"
    end
    puts str + "Enter matching number and press enter:"
    guess = gets.chomp.to_i - 1
    
    if(defs[guess] == entry[1])
      puts "AWW YISS!"
      correct = true
    else
      puts "oops. I'm sure you meant: #{entry[1]}"
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