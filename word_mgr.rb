class WordMgr
  
  attr_reader :words
  def initialize
    @words = {}
  end
  
  def load_words file
    words = {}
    puts file
    if(File.exists?(file))
      File.readlines(file).each do |line|
        if line.match(/\w+/)
          entry = line.split(' - ').map{|i|i.rstrip}
          @words[entry[0]] = entry[1]
          p entry
        end
      end
    end
  end
  
end