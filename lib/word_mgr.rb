require 'yaml'
require 'time'
class WordMgr
  
  attr_reader :words, :groups, :matched, :missed
  
  def read_state_file(path)
    state = YAML::load_file(path)
    
    @words = state.words
    @groups = state.groups
    @matched = state.matched
    @missed = state.missed
    
    #values.each{|k,v| instance_variable_set("@#{k}", v)}
  end
  
  def save
    data = YAML::dump(self)
    File.open(@state_path, 'w') { |file| file.write data }
  end
  
  def initialize(path)
    @state_path = path + "/state.yml"
    if(File.exists?(@state_path))
      read_state_file(@state_path)
    else
      @words = []
      @groups = []
      @matched = []
      @missed = Hash.new(0)
      save
    end
  end
  
  def load_words file
    puts file
    @groups = []
    @words = []
    @matched = []
    if(File.exists?(file))
      File.readlines(file).each do |line|
        if line.match(/\w+/)
          entry = line.split(' - ').map{|i|i.rstrip}
          @words << [entry[0], entry[1]]
          p entry
        end
      end
      @words.shuffle!
      @groups << file
    end
    save
  end
  
  def rand_entry(num = 1)
    if(!@words.empty?)
      @words[rand(@words.count)]
    else
      @matched[rand(@matched.count)]
    end
  end
  
  def rand_word
    rand_entry[0]
  end
  
  def rand_def(num = 1)
    (@words + @matched).sample(num).map{|i|i[1]}
  end
  
  def match matched_word
    wrd = @words.select{|w|w[0] == matched_word}
    @matched << wrd[0]
    @words.delete(wrd[0])
    save
  end
  
  def miss missed_word
    wrd = @words.select{|w| w[0] == missed_word}[0]
    
    if(@missed[wrd] == nil)
      @missed[wrd] = 1
    else
      @missed[wrd] = @missed[wrd] + 1
    end
    save
  end
  
  def reset_words
    @matched.each do |entry|
      @words << entry unless @words.include? entry
    end
    @matched = []
    save
  end
  
  def reset_missed
    @missed = {}
    save
  end
  
  def generate_missed_word_list(path)
    data = ""
    @missed.each do |entry, miss_count|
      data << "#{entry[0]} - #{entry[1]}\n\n"
    end
    filename = "#{path}/most_missed-#{DateTime.now.to_s}.txt"
    File.open(filename, 'w'){|file| file.write(data)}
    puts "\nmost-missed deck created: #{filename}"
  end

  
  
end