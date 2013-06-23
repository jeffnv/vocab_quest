class WordMgr
  @words
  def initialize
    @words = {}
  end
  
  def load_words file
    words = {}
    if(File.exists?(file))
      puts file
    end
  end
  
end