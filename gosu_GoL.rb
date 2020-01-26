# Gosu file 

require 'gosu' 
require_relative 'game_of_life.rb'

class GoLWindow < Gosu::Window  # our GoLWindow class inherits from Gosu::Window

   def initialize(height=800, width=600)
      @height = height 
      @width = width 
      super height, width, false
      self.caption = "Lee's Super-Awesome Game of Life"

      # colour 
      @background_colour = Gosu::Color.new(0xff_ffffed)
      @alive_colour = Gosu::Color.new(0xff_5454ff) 

      # initialising game 
      @cols = width/10   
      @rows = height/10

      @col_width = width/@cols
      @row_height = height/@rows
      
      @world = World.new(@cols, @rows) # pulls World class from main .rb
      @game = Game.new(@world)       # pulls Game class from main .rb file  
      @game.world.randomly_populate
      
   end 
   
   # 'update' updates your game 60 times p/sec, normally contains all your game    #  logic, but we gave ours in the separate game_of_life.rb file 

   def update
     @game.tick!	   
   end 

   def draw 
     draw_quad(0, 0, @background_colour, 
	       width, 0, @background_colour,
	       width, height, @background_colour,
	       0, height, @background_colour)

     # give cells colour and shape 

     @game.world.cells.each do |cell|
        if cell.alive?
	   draw_quad(cell.x * @col_width, cell.y * @row_height, @alive_colour,
                     cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @alive_colour,
		     cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @alive_colour,
		     cell.x * @col_width, cell.y * @row_height + (@row_height -1), @alive_colour)
	else
           draw_quad(cell.x * @col_width, cell.y * @row_height, @background_colour,
		     cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @background_colour,
                     cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @background_colour,
                     cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @background_colour)

        end
      end	
   end 

   def needs_cursor?; true; end 
end

window = GoLWindow.new
window.show

