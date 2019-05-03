# Conways Game Of Life realised in MatLab.     
Produced as an assignment for ENG 1002 - Programming (Matlab and C) at the University of Adelade 2019     
hamish.west@student.adelaide.edu.au    
   
# Configuration options available:    
seedString: String containing a seed in groups of 7    
seedVect: Vector containing an initial condition in 0,1   
simulationSpeed: speed = .5/simulationSpeed. n=1, t=.5s; n=2, t=.25s   
contSeed: Is the seed destoyed after the first turn or is it constant?  
mapSize{Rows,Cols}: Defines the size of the play area. 100x100 is recommended though 256 works better with the hex config of the seed string  
  
# Seed Format    
Seed string format is XXYYTXY. (XX,YY) defines the top left corner of the square. T defines the type of the cell, def=1. (X,Y) is the size of the square in base 16(Hex)   
Example seed string: 3232188   
The above seed starts at (32, 32){Base 16} or (50,50){Base 10}. Has type 1 and is 8 units in size on both x and y axis.    

