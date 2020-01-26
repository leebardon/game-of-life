# game code

class Game
     attr_accessor :world, :seeds	
     def initialize(world=World.new, seeds=[])
	 @world = world 
	 @seeds = seeds

	 seeds.each do |seed|
	    world.grid[seed[0]][seed[1]].alive = true
	 end
     end

     def tick!
       
       next_round_living_cells = []   # status temporarily stored here instead of instantaneously
       next_round_dead_cells = []     # changing during iteration 
	     
       world.cells.each do |cell| 
           # rule 1
           if cell.alive? and world.live_neighbours(cell).count < 2
	      next_round_dead_cells << cell
           end

	   # rule 2
	   if cell.alive? and ([2, 3].include? world.live_neighbours(cell).count)
	      next_round_living_cells << cell   
       	   end

	   # rule 3
	   if cell.alive? and world.live_neighbours(cell).count > 3 
              next_round_dead_cells << cell
	   end
           
	   # rule 4
	   if cell.dead? and world.live_neighbours(cell).count == 3
	      next_round_living_cells << cell 
	   end
       end

       next_round_living_cells.each do |cell| 
	   cell.revive!
       end 

       next_round_dead_cells.each do |cell|
	   cell.die!
       end  
   end
end

class World
                                 # allows these to be accessed by tests		
    attr_accessor :rows, :cols, :grid, :cells	
    def initialize(rows=3, cols=3)
      @rows = rows
      @cols = cols
      @cells = []
      @grid = Array.new(rows) do |row|
	      	Array.new(cols) do |col|
		  cell = Cell.new(col, row)
		  cells << cell 
                  cell
		end
	      end
    end

    def live_neighbours(cell)
      live_neighbours_arr = []

      # detects a neighbour to the north
      if cell.y > 0            # this excludes top row [0,0] to [0,2], as there is no row above
        candidate = self.grid[cell.y - 1][cell.x]   # self references the world here 
        live_neighbours_arr << candidate if candidate.alive? 	
      end
      # detects a neighbour to the north-east 
      if cell.y > 0 and cell.x < (cols - 1)
        candidate = self.grid[cell.y - 1][cell.x + 1]
	live_neighbours_arr << candidate if candidate.alive? 
      end
      # detects a neighbour to the south-east 
      if cell.y < (rows - 1) and cell.x < (cols - 1)
        candidate = self.grid[cell.y + 1][cell.x + 1]
        live_neighbours_arr << candidate if candidate.alive?
      end
      # detects neighbours to the south-west 
      if cell.y < (rows - 1) and cell.x > 0
        candidate = self.grid[cell.y + 1][cell.x - 1]
        live_neighbours_arr << candidate if candidate.alive?
      end
      # detects neighbours to the north-west 
      if cell.y > 0 and cell.x > 0
        candidate = self.grid[cell.y - 1][cell.x - 1]
        live_neighbours_arr << candidate if candidate.alive?
      end
      #detects neighbours to the east 
      if cell.x < (cols - 1)
        candidate = self.grid[cell.y][cell.x + 1]
        live_neighbours_arr << candidate if candidate.alive?
      end
      # detects neighbours to the south 
      if cell.y < (rows - 1)
        candidate = self.grid[cell.y + 1][cell.x]
        live_neighbours_arr << candidate if candidate.alive?
      end
      # detects neighbours to the west 
     if cell.x > 0
        candidate = self.grid[cell.y][cell.x - 1]
	live_neighbours_arr << candidate if candidate.alive?
     end

    live_neighbours_arr 
    end
    
    def live_cells
      cells.select { |cell| cell.alive } 
    end 

    def randomly_populate
      cells.each do |cell| 
        cell.alive = [true, false].sample
      end 
    end 
    
end 

class Cell
      attr_accessor :alive, :x, :y
      def initialize(x=0, y=0) 
        @alive = false
       	@x = x
	@y = y
      end

     def alive?; alive; end    
     def dead?; !alive; end

     def die! 
       @alive = false
     end

     def revive!
       @alive = true
     end
end

