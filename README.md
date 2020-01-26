# Game-of-Life

# INTRODUCTION 

This is my implementation of John Conway's Game of Life, based on the 
2013 YouTube tutorial given by user SDuplic. The game is developed in Ruby, 
with Test Driven Development in rspec, and visualised with Gosu.  

Conway's Game of Life is a topic that I first encountered as an undergrad,
during a module on cellular automata and complex systems modelling. I was 
especially interested in the topics of emergence and self-organisation - 
how complex structures and behaviours can arise from a few simple rules - and
the implications to topics in CS, tech, and the natural sciences.  

My initial exposure to this topic was through NetLogo patches, so I 
couldn't resist the opportunity to learn how to build the game in Ruby, while
gaining a more thorough understanding of Test-Driven Development.       

The core game logic hasn't been altered significantly from SDuplic's version. 
However, rspec has since gone through a lot of changes, so this portion of his 
build needed to be updated throughout. 


# WHAT YOU NEED 

In order to run this game, you need to have installed Ruby and the Gosu 2D 
game development library (see https://www.libgosu.org/). Gosu depends 
on the SDL 2 Library, and both are available for Linux, macOS and Windows.     
 

# HOW TO PLAY 

This is a zero-player game where the initial condition consists of randomly 
populated cells on a grid that are either 'alive' or 'dead'. The state 
of the cells/agents is updated on each game loop (at 60 FPS) according 
to the following rules:

1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

# THINGS TO NOTICE

Are there any objects that are consistently alive, but motionless?
Are there any recurring shapes, patterns and movements?

Although this is a simple implementation, the Game of Life has attracted interest 
due to the ways in which the cells can evolve. For example, life could be  
arguably considered as an example of emergence and self-organisation arising from the 
implementation of a few simple rules. 
