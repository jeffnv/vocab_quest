puts "Welcome to the quest!"
choice = ''
until choice.downcase.start_with? 'q'
  puts "enter q to quit"
  choice = gets.chomp
end
