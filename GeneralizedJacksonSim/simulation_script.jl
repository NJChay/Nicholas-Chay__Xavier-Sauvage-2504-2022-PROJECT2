using Plots
include("src/sim.jl")
include("src/Task2.jl")
include("tests/All_tests.jl")


#sim file contains the simulation engine and makes use of all files given in the a2 spec 
#GeneralizedJacksonSim is where the module is defined 


#only scenario 1 plots used as intermediate output 

#~5 mins to run 

plot(tp1,#theory TSSMQL
pl1,#simulation TSSMQL
e1, #error between the scenarios 
ep1,ep4, #error between run times 
p1) #Effects of different c values on TSSMQL