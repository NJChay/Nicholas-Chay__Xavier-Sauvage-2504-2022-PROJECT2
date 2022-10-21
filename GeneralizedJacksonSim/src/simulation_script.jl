using Plots
include("c:\\Users\\User\\OneDrive\\MATH2504\\Proj2\\Nicholas-Chay__Xavier-Sauvage-2504-2022-PROJECT2\\GeneralizedJacksonSim\\src\\sim.jl")
include("c:\\Users\\User\\OneDrive\\MATH2504\\Proj2\\Nicholas-Chay__Xavier-Sauvage-2504-2022-PROJECT2\\GeneralizedJacksonSim\\src\\Task2.jl")
include("c:\\Users\\User\\OneDrive\\MATH2504\\Proj2\\Nicholas-Chay__Xavier-Sauvage-2504-2022-PROJECT2\\GeneralizedJacksonSim\\tests\\All_tests.jl")


#sim file contains the simulation engine and makes use of all files given in the a2 spec 
#GeneralizedJacksonSim is where the module is defined 


#only scenario 1 plots used as intermediate output 

#~5 mins to run 

plot(tp1,#theory TSSMQL
pl1,#simulation TSSMQL
e1, #error between the scenarios 
ep1,ep4, #error between run times 
p1) #Effects of different c values on TSSMQL