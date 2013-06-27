class FeedbackMgr
  def read_file(full_path)
    result = []
    if(File.exists?(full_path))
      File.readlines(full_path).each do |line|
        result << line.rstrip
      end
      p result
    end
    result
  end
  
  def initialize(path)
    @good = []
    @bad = []
     f1 = path + "/congrats.txt"
     f2 = path + "/fail.txt"
     @good = read_file f1
     @bad = read_file f2
  end
  
  def yes
    @good.sample
  end
  
  def no
    @bad.sample
  end
end