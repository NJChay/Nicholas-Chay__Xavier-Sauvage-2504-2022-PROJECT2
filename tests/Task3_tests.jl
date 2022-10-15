include("Task2.jl")

p_star=0.1:0.01:0.9
p_nets1,p_nets2,p_nets3,p_nets4=[],[],[],[]

[push!(p_nets1,set_scenario(scenario1,p)) for p in p_star]

[push!(p_nets2,set_scenario(scenario2,p)) for p in p_star]

[push!(p_nets3,set_scenario(scenario3,p)) for p in p_star]

[push!(p_nets4,set_scenario(scenario4,p)) for p in p_star]


TSSMQL1=[]
[push!(TSSMQL1,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets1]

TSSMQL2=[]
[push!(TSSMQL2,sim_net(net)) for net in p_nets2]

TSSMQL3=[]
[push!(TSSMQL3,sim_net(net)) for net in p_nets3]

TSSMQL4=[]
[push!(TSSMQL4,sim_net(net)) for net in p_nets4]



p1 = plot(p_star, TSSMQL1, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 1",
        label = false, lw = 2, c = :black)
    
p2 = plot(p_star, TSSMQL2, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 2",
        label = false, lw = 2, c = :black)

p3 = plot(p_star, TSSMQL3, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 3",
        label = false, lw = 2, c = :black)

p4 = plot(p_star, TSSMQL4, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 4",
        label = false, lw = 2, c = :black)
    
    
plot(p1,p2,p3,p4) 


"""
Error graph
"""
#100 time
TSSMQL1_100=[]
[push!(TSSMQL1_100,sim_net(net,max_time=10^2,warm_up_time=10)) for net in p_nets1]

ARE1_100=abs.((TSSMQL1_100.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep1 = plot(p_star, ARE1_100, 
        xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^2",
        label = false, lw = 2, c = :black)



#1000 time
ARE1_1000=abs.((TSSMQL1.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep2 = plot(p_star, ARE1_1000, 
        xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^3",
        label = false, lw = 2, c = :black)

#10000 time
TSSMQL1_10000=[]
[push!(TSSMQL1_10000,sim_net(net,max_time=10^4,warm_up_time=10^3)) for net in p_nets1]

ARE1_10000=abs.((TSSMQL1_10000.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep3 = plot(p_star, ARE1_10000, 
xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^4",
label = false, lw = 2, c = :black)

#100000 time
TSSMQL1_105=[]
[push!(TSSMQL1_105,sim_net(net,max_time=10^5,warm_up_time=10^4)) for net in p_nets1]

ARE1_105=abs.((TSSMQL1_105.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep4 = plot(p_star, ARE1_105, 
xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^5",
label = false, lw = 2, c = :black)

plot(ep1,ep2,ep3,ep4)
