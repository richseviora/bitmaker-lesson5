module CLEARSCREEN
  def clear_screen
    puts "\e[H\e[2J"
  end
end
