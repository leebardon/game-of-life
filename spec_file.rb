# rspec file
 
require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of Life' do

    let!(:world) { World.new } # creates a new world obj when 'world' variable is referenced 	
    let!(:cell) { Cell.new(1, 1) }

    
  context 'World' do   # i.e. Class
  subject { World.new }

       it 'should create a new World object' do 
          expect(World).to be_truthy
       end

       it 'should respond to proper methods' do 
          expect(subject).to respond_to(:rows) 
	  expect(subject).to respond_to(:cols)
	  expect(subject).to respond_to(:grid)
	  expect(subject).to respond_to(:live_neighbours)
	  expect(subject).to respond_to(:cells)
          expect(subject).to respond_to(:randomly_populate)
	  expect(subject).to respond_to(:live_cells)
       end

       it 'should create a cell grid on initialisation' do
	  expect(subject.grid.is_a?(Array)).to be_truthy

	    subject.grid.each do |row|
	        expect(row).to be_an(Array)
		row.each do |col|
		   expect(col).to be_a(Cell)
		end
	    end
        end
      
        it 'should add all cells to cells array' do
           expect(subject.cells.count).to eq 9   # default grid is 3 x 3
        end

        it 'should detect live neighbour to the north' do
	   subject.grid[cell.y - 1][cell.x].alive = true 
	   expect(subject.live_neighbours(cell).count).to eq 1 
         end	    
        it 'should detect live neighbour to the north-east' do
           subject.grid[cell.y - 1][cell.x + 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the south-east' do
           subject.grid[cell.y + 1][cell.x + 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the south-west' do
           subject.grid[cell.y + 1][cell.x - 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the north-west' do
           subject.grid[cell.y - 1][cell.x - 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the east' do
           subject.grid[cell.y][cell.x + 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the south' do
           subject.grid[cell.y + 1][cell.x].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end
        it 'should detect live neighbour to the west' do
           subject.grid[cell.y][cell.x - 1].alive = true
           expect(subject.live_neighbours(cell).count).to eq 1
        end

	it 'should randomly populate the world on initialisation' do
           expect((subject.live_cells).count).to eq 0
	   subject.randomly_populate
           expect((subject.live_cells).count).not_to eq 0	   
	end 

    end

    context 'Cell' do
      subject { Cell.new}

      it 'should create a new Cell object' do
	  expect(subject).to be_a(Cell)
      end

      it 'should respond to the correct methods' do
	  expect(subject).to respond_to(:alive)  # subject is Cell.new
	  expect(subject).to respond_to(:x)
	  expect(subject).to respond_to(:y)
	  expect(subject).to respond_to(:alive?)
	  expect(subject).to respond_to(:die!)
      end

      it 'should initialize' do
      	  expect(subject.alive).to be_falsy
	  expect(subject.x).to eq 0
	  expect(subject.y).to eq 0
      end
    end

    context 'Game' do
    subject { Game.new }

      it 'should create a new game object' do
	 expect(Game).to be_truthy
      end

      it 'should respond to correct methods' do
	  expect(subject).to respond_to(:world)
	  expect(subject).to respond_to(:seeds)
      end

      it 'should initialize properly' do
	  expect(subject.world).to be_truthy
	  expect(subject.seeds).to be_an(Array)
      end

      it 'should plant seeds properly' do
	  game = Game.new(world, [[1, 2], [0, 2]])
	  expect(world.grid[1][2]).to be_alive
	  expect(world.grid[0][2]).to be_alive
      end 
   end
	
   context 'Rules' do
   let!(:game) { Game.new } 

     context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if by underpopul              ation.' do
        
        it 'should kills live cell with no neighbours' do
	   game.world.grid[1][1].alive = true 
           expect(game.world.grid[1][1]).to be_alive
           game.tick!
           expect(game.world.grid[1][1]).to be_dead
        end
	     
        it 'should kill a live cell with 1 live neighbour' do
	    game = Game.new(world, [[1, 0], [2, 0]])
	    game.tick! # tick! changes object permanantly between iterations 
	    expect(world.grid[1][0]).to be_dead
	    expect(world.grid[2][0]).to be_dead  
	end
        
	it 'Keeps live cells with 2 or more neighbours alive' do
           game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
           game.tick!
           expect(world.grid[1][1]).to be_alive
        end
     end

	context 'Rule 2: Any live cell with two or three live neighbours lives on to the next gen                 eration.' do
	 
           it 'should keep cell with two live neighbours alive in the next generation' do
	      game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
              expect(world.live_neighbours(world.grid[1][1]).count).to eq 2
              game.tick!
              expect(world.grid[0][1]).to be_dead
              expect(world.grid[1][1]).to be_alive
              expect(world.grid[2][1]).to be_dead
            end 	
        
	    it 'Should keep cell with 3 neighbours alive to next generation' do
              game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2]])
              expect(world.live_neighbours(world.grid[1][1]).count).to eq 3
              game.tick!
              expect(world.grid[0][1]).to be_dead
              expect(world.grid[1][1]).to be_alive
              expect(world.grid[2][1]).to be_alive
              expect(world.grid[2][2]).to be_alive
            end
	end
       
       	context 'Rule 3: Live cell with more than three live neighbours dies (overcrowding).' do
            it 'Should kill live cells with more than 3 live neighbours' do
              game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2], [1, 2]])
              expect(world.live_neighbours(world.grid[1][1]).count).to eq 4
              game.tick!
              expect(world.grid[0][1]).to be_alive
              expect(world.grid[1][1]).to be_dead
              expect(world.grid[2][1]).to be_alive
              expect(world.grid[2][2]).to be_alive
              expect(world.grid[1][2]).to be_dead
            end
        end
        
        context 'Rule 4: Dead cells with three live neighbours become live (reproduction).' do
          it 'Revives dead cell with 3 neighbours' do
             game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
             expect(world.live_neighbours(world.grid[1][0]).count).to eq 3
             game.tick!
             expect(world.grid[1][0]).to be_alive
             expect(world.grid[1][2]).to be_alive
          end
        end
   

   end



end 
