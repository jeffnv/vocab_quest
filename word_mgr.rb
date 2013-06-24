class WordMgr
  
  attr_reader :words, :groups
  def initialize
    @words = []
    @groups = []
    @matched = []
    @missed = []
  end
  
  def load_words file
    puts file
    if(File.exists?(file) && !@groups.include?(file))
      File.readlines(file).each do |line|
        if line.match(/\w+/)
          entry = line.split(' - ').map{|i|i.rstrip}
          @words << [entry[0], entry[1]]
          p entry
        end
      end
      @groups << file
    end
  end
  
  def rand_entry
    count = @words.count
    @words[rand(count)]
  end
  
  def rand_word
    rand_entry[0]
  end
  
  def rand_def
    rand_entry[1]
  end
  
  def matched word
    @matched << word
  end
  
  def missed word
    @missed << word
  end
  
  
end