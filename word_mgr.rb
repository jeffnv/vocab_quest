class WordMgr
  
  attr_reader :words, :groups
  def initialize
    @words = []
    @groups = []
    @matched = []
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
      @words.shuffle!
      @groups << file
    end
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
  
  def matched matched_word
    wrd = @words.select{|w|w[0] == matched_word}
    @matched << wrd
    @words.delete(wrd)
  end
  
  
end