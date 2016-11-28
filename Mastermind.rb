require 'colorize'
class Board
  attr_accessor :the_board, :code, :game_over, :turn_count, :colors
  def initialize()
    #variables
	@colors = ["white", "red", "green", "yellow", "blue", "magenta", "cyan", "black"]
	@game_over = false
	@turn_count = 0
	@the_board=[]		
	@code = []
	@hints = []
	#inializes arrays
	4.times{@code.push(@colors[rand(0..7)])}
	32.times{|x| @the_board.push("o")}
  end
  
  def show_board
	#Clears screen - draws board
	system("cls")
	puts "    Mastermind     ".bold.red.on_white.blink
	2.times{puts ""}
	
	if @game_over == false
		#print "Code: ? ? ? ?\n"
		print "#{@code}\n"
	else
		print "#{@code}\n"
	end
	print "\n   1   2   3   4\n"
	print "  ---------------\n"
	
	(1..the_board.length).each{|x|		
		if x%4==0		
		  if the_board[x-1] == "o"
			print " | #{the_board[x-1]} |  "			
		  else
		    print " | #{the_board[x-1][0].send(the_board[x-1]).bold} |  "
		  end
		  print @hints[x-4], @hints[x-3], @hints[x-2], @hints[x-1], "\n"
		else 
		  if the_board[x-1] == "o"
		    print " | #{the_board[x-1]}"
		  else
		    print " | #{the_board[x-1][0].send(the_board[x-1]).bold}"
		  end		  
		end
		 
		 
		 
		}
	print "  ---------------\n"
	print "Color Options: "
	@colors.each{|color|
		if color != "black"
			print "#{color}, "
		else
			print "black."
		end
	}
	2.times{puts ""}
  end
 
  def new_code
    @code = []
	4.times{@code.push(@colors[rand(0..7)])}
  end
  
  def reset_board
    @the_board=[]
    36.times{|x| @the_board.push("o")}	
  end  
  
  def next_turn
	4.times{
		print "What color for slot #{@turn_count%4 +1}? "
		guess = gets.chomp
		@the_board[@turn_count]=guess
		puts @code[turn_count%4]
	    puts @the_board[@turn_count]		
		if  @code.include? @the_board[@turn_count]
			if @the_board[@turn_count] == @code[turn_count%4] 
			  @hints.push("Y")
			 else
			  @hints.push("X")
			 end
		else
			@hints.push(" ")
		end
		@turn_count+=1
	}
	(1..the_board.length).each{|x|
	if @hints[x-4]=="Y" && @hints[x-3]=="Y" && @hints[x-2]=="Y" && @hints[x-1]=="Y"
			@game_over = true
			self.show_board
			puts "You win!!!!!"
		 end
	}
	if @turn_count > 31
		
		self.show_board
		puts "You lose!! Better luck next time!"
		@game_over = true
	end
  end
end

game = Board.new

puts "\nWould you like to be 1)Codebreaker or 2)Codemaker?"
game_type = gets.chomp
if game_type.to_i == 1
	while game.game_over==false	  
	  game.show_board
	  game.next_turn  	  
	end
end

puts "GAME OVER"